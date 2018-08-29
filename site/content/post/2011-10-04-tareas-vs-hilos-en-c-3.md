---
title: 'Tareas Vs. Hilos en C#'
author: clausia
layout: post
date: 2011-10-04
url: /2011/10/04/tareas-vs-hilos-en-c-3/
categories:
  - article
tags:
  - 'c#'
  - concurrencia
  - hilos
---
Hace algunos meses comencé en un nuevo trabajo, prometía muchos retos y sobre todos un gran cambio a lo que estaba acostumbrada. Para empezar, se trataba de programar aplicaciones de escritorio y ya no más aplicaciones web, que es lo que había hecho desde siempre; otro gran cambio fue el tener que programar (inicialmente) en C#, toda mi carrera profesional he programado en Java, desde la escuela incluso y aunque muchos decimos que C# es la mala copia de Java, debo decir que ahora que lo conozco un poco más, tiene sus detalles agradables.

Una de ellos fue el manejo de hilos. Los nuevos requerimeintos que debía satisfacer, requieren que se hagan cálculos con millones de datos, la velocidad es crucial, ya que se obtiene el siguiente dato en la orden de cien milésimas de segundo, y no es que el cálculo en sí tarde más que esa pequeña ventana de tiempo, sino que esperamos que se disparen varios eventos por cada dato, de tal modo que el hilo principal siga teniendo la oportunidad de manejar todos los eventos sin esperarse a que alguno de estos termine, incluyendo el pintado de la interfaz gráfica. Lo primero que me vino a la mente para esto fueron los hilos (gracias hilos por existir), pero comencé a toparme con detallles, uno de ellos es que todos los hilos se ejecutaban en algunos <em>cores </em>solamente, a pesar de que el server tiene 24 núcleos, trabajaban como locos los <em>cores </em>elegidos al azar, mientras se desperdiciaban los demás. Una búsqueda en la red me llevó al descubrimiento de las Tareas del .NET Framework 4.0 las cuales se encargan de generar los hilos, ¿cuántos y cómo? solo el CLR lo sabe, pero lo que también sabe es cuántos <em>cores </em>hay disponibles y la caga de trabajo que ya tienen, de tal modo que balancea los hilos generados y los ditribuye entre todos los núcleos. Problema resuelto para mi aplicación de escritorio.

Veamos la diferencia entre el uso de hilos y el uso de tareas con C# (a partir de la versión 4.0 del .NET Framework necesariamente). Primero el ejemplo con hilos:

```cs
class Program
{
   static void Main(string[] args)
   {
       DateTime inicio = DateTime.Now;
       for (int i = 0; i < 100000; i++)
       {
           int temp = i;
           Thread t = new Thread(() => method1(temp));
           t.Start();
       }
       DateTime fin = DateTime.Now;
       TimeSpan diff = fin - inicio;
       Console.WriteLine("Inicio= {0} - Fin= {1} - Diferencia= {2}:{3}:{4}.{5}",
                          inicio.ToString("yyyy/MM/dd HH:mm:ss.fffffff"),
                          fin.ToString("yyyy/MM/dd HH:mm:ss.fffffff"),
                          diff.Hours, diff.Minutes, diff.Seconds,
                          diff.Milliseconds;
       Console.ReadLine();
   }

   static void method1(int i)
   {
       for (int j = 0; j < 10000; j++)
       {
           double d = 45345 / 6546 * 7989 / 0.2254;  //cualquier procesamiento...
       }
   }
}
```

La ejecución de este código muestra en su salida:

```
Inicio= 2011/09/29 21:39:33.6400926 - Fin= 2011/09/29 21:53:23.1265365 - Diferencia= 0:13:49.486
```

Como podemos ver, se tardó casi 14 minutos en lanzar los hilos, <strong>solamente en generarlos</strong>, cuando descubrí esto, vi que no me servía la utilización directa de muchos hilos, ya que hubiera tenido que idear una manera (sofisticada) de adminsitrar su generación para que f

Afortunadamente, los creadores del .NET Framework se preocuparon por proveer mecanismos eficientes para el manejo de concurrencia, apartír de la versión 4.0, entre esos mecanismos, existe la clase Task, la cual para fines prácticos, es como tener hilos ya que permite ejecutar procesos en paralelo. Veamos el mismo ejemplo con tareas:

```
class Program
{
   static void Main(string[] args)
   {
       DateTime inicio = DateTime.Now;
       for (int i = 0; i < 100000; i++)
       {
           int temp = i;
           Task t = Task.Factory.StartNew(() => method1(temp));
       }
       DateTime fin = DateTime.Now;
       TimeSpan diff = fin - inicio;
       Console.WriteLine("Inicio= {0} - Fin= {1} - Diferencia= {2}:{3}:{4}.{5}",
                          inicio.ToString("yyyy/MM/dd HH:mm:ss.fffffff"),
                          fin.ToString("yyyy/MM/dd HH:mm:ss.fffffff"),
                          diff.Hours, diff.Minutes, diff.Seconds,
                          diff.Milliseconds;
       Console.ReadLine();
   }

   static void method1(int i)
   {
       for (int j = 0; j < 10000; j++)
       {
           double d = 45345 / 6546 * 7989 / 0.2254;  //cualquier procesamiento...
       }
   }
}
```

Con la siguiente salida:

```
Inicio= 2011/09/29 21:39:07.0425713 - Fin= 2011/09/29 21:39:07.0975745 - Diferencia= 0:0:0.133
```

Como podemos notar, la diferencia entre lanzar hilos y tareas es abismal, lanzar las tareas ha tomado solamente 133 milisegundos!.

¿Por qué es tan grande la diferencia? Resulta que las tareas, en algún momento se convierten el hilos, pero nosotros no somos los encargados de decidir cúantos ni cuándo serán lanzados, quien se encarga es el CLR (<em>Common Language Runtime</em>). Para mi sorpresa, el CLR se entera bien de cúantos núcleos existen y de cuánta carga de trabajo tienen, y en base a eso, es que decide cómo repartir las unidades de procesamiento (Tasks) en los hilos, los cuales son reutilizados una vez que terminan de hacer su trabajo. Al parecer esta pequeña, pero importante diferencia, le ahorra mucho tiempo al sistema operativo en cuestión de adminsitrar los hilos de ejecución.

Esto fue solo el inicio del desarrollo de aplicaciones paralelas que he comenzado a programar, existen muchas monerias que se pueden explotar en cuanto a paralelo en .NET 4.0 se refiere, como se puede apreciar en la siguiente imagen, las características que se incorporaron en esta versión están enfocadas principalmente al paralelo.

<img src="http://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/DotNet.svg/250px-DotNet.svg.png" alt="Evolución de las versiones del .NET Framework" width="250" height="292" />

He escuchado que en la versión 7 de Java existen las Tareas y en algunos meses desarrollaré el mismo tipo de aplicaciones, pero en Java, espero sinceramente que la JVM también se destaque en la administración de unidades de procesamiento, de lo contrario me tocará sufrir con este tema. Si alguien ha tenido la oportunidad de explotar esta característica de Java, le agradeceré que comparta su experiencia.

Como recomendación, pueden referirse al libro llamado &#8220;<a href="http://www.amazon.com/NET-Parallel-Programming-Experts-Voice/dp/1430229675" target="_blank">Pro .NET 4 Parallel Programming in C#</a>&#8221; del autor <em>Adam Freeman</em>, el cual me ha sido de mucha ayuda.

Claudia (<a href="http://twitter.com/#!/clausia" target="_blank">@clausia</a>)
