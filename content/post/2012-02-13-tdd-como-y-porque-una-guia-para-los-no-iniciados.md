---
title: 'TDD Cómo y porqué: Una guía para los no iniciados'
author: Alfredo Chavez
layout: post
date: 2012-02-13
url: /2012/02/13/tdd-como-y-porque-una-guia-para-los-no-iniciados/
categories:
  - Article
tags:
  - tdd
  - Extreme Programming
  - testing
  - python
---

## Introducción

Esta es mi primera contribución para _Artesanos de Software_.

Soy un desarrollador de software "de la vieja escuela", por decirlo de alguna manera. Hace años, pensaba que tenía bastante dominado este asunto de la programación, hasta que me topé con [_Extreme Programming_][1]</a> y todo el ecosistema de Métodos Ágiles que se ha desarrollado desde entonces. Para mi, todo cambió desde entonces y me dí cuenta de lo poco que sé en realidad. He estado practicando la disciplina del Desarrollo Dirigido por Pruebas o <acronym title="Test Driven Development">TDD</acronym> ahora si y ahora no por los últimos ocho años. Quienes me conozcan, sabrán que no ha sido ni por mucho un proceso fácil ni mucho menos rápido. Sin embargo, si solo pudiera lograr que todos los desarrolladores de mi equipo adoptaran una sola práctica de <acronym title="Extreme Programming">XP</acronym>, esa sería <acronym title="Test Driven Development">TDD</acronym>.

Las excusas abundan, es simplemente demasiado fácil ceder y dejar de hacerlo. Desde los clásicos _"en mi empresa no me lo permiten"_ y _"mi jefe dice que me pagan por escribir funcionalidad, no pruebas"_ hasta los no tan infrecuentes _"las pruebas son trabajo de QA, no mio"_ o _"esta porquería es una mi3rd@, ¡es imposible de probar!"_. Lo sé porque yo mismo he estado en esas situaciones, he dado las mismas excusas y ni una sola vez puedo decir que el resultado haya sido positivo para mi o para el proyecto.

El propósito de este blog es allanar un poco el camino para aquellos que estén considerando aprender <acronym title="Test Driven Development">TDD</acronym> y posiblemente utilizarlo en su trabajo o en proyectos personales. Para mi no ha sido fácil y aún estoy aprendiendo. Si alguien puede sacar algo en claro de mis propias experiencias pasadas, creo que eso será más que suficiente para compensar el tiempo invertido en el mismo.

Este blog debe considerarse un trabajo en progreso. La idea del mismo comenzó hace probablemente tres o cuatro meses. Simplemente hay demasiados temas y ángulos para cubrir de una sola vez. El material disponible en la red, las anécdotas personales, las técnicas, los _"pitfalls"_ (alguien, español por favor?), los _"tips"_, etc. son suficientes como para llenar uno o varios libros así que no puedo esperar cubrir todas las bases en un solo post. Debido a ello, en este post me concentraré exclusivamente en el tema de las pruebas unitarias. Solo el tiempo dirá si soy capaz de llevar este proyecto a buen término :-)

## ¿Qué es <acronym title="Test Driven Development">TDD</acronym>?

<acronym title="Test Driven Development">TDD</acronym> es una criatura extraña. Es simple de definir, pero su definición parece ir en contra del sentido común. Es sencilla de explicar, pero difícil de llevar a cabo. Y una vez que superas la resistencia intelectual inicial (the "<acronym title="¿Qué carajos?">_WTF_</acronym> factor") y lo entiendes, es difícil de dominar.

> ### Definición
>
> Es una disciplina que promueve el desarrollo de software con altos niveles de calidad, simplicidad de diseño y productividad del programador, mediante la utilización de una amplia gama de tipos de pruebas automáticas a lo largo de todo el ciclo de vida del software. El principio fundamental es que las pruebas se escriben antes que el software de producción y estas constituyen la especificación objetiva del mismo.

La primera parte de la definición suena todo miel sobre hojuelas. ¿Quién no quiere software confiable, bien diseñado y producido rápidamente?. Sin embargo, todo esto no viene gratuitamente; la palabra clave aquí es _disciplina_.

> ### Disciplina:
>
> Doctrina, instrucción de una persona, especialmente en lo moral. Observancia de las leyes y ordenamientos de la profesión o instituto.

Esto nos lleva a la conclusión de que si <acronym title="Test Driven Development">TDD</acronym> es en efecto una disciplina, entonces no es algo que aplicamos "según nos vayamos sintiendo", más bien, es algo que debe formar parte integral de nuestra profesión o arte (según la perspectiva de cada quien).

La segunda parte de la definición viene con el primer "<acronym title="¿Qué carajos?">_WTF_</acronym>" para muchos: Las pruebas se deben escribir __antes__ que el _software_ mismo. La primera impresión de muchos (incluyendo a _yours truely_) es "¿eh?, ¿y cómo demonios escribo una prueba para software que todavía no existe?".

Cuando aprendemos a programar, los más afortunados comienzan con algún lenguaje interpretado como Basic, Logo o Scheme (para los más veteranos) o Ruby y Python. Normalmente comenzamos con cosas simples como por ejemplo, sumar 2 y 3:

```ruby
>>> 2 + 3
5
```

Intuitivamente pensamos _"debe dar cinco"_, incluso __antes__ de oprimir la tecla <tt>ENTER</tt>; y normalmente funciona o si no, entonces hay algo definitivamente mal con el lenguaje o con nuestro entendimiento del mismo. Posteriormente pasamos a cosas más complejas y/o sofisticadas, como por ejemplo:

```ruby
>>> a = 2
>>> a + 3
5
>>> b = 3
>>> a + b
5
>>> def sum(a, b):
...   return a + b
...
>>> sum(2, 3)
5
```

Etcétera. Todo el tiempo verificamos que el resultado es el que esperamos, aunque "sabemos" que así debería ser. Cada vez que vemos el resultado que esperamos aparecer en la pantalla, aumenta nuestra autoconfianza, lo que nos motiva a seguir aprendiendo, a seguir programando. Este podría tal vez ser el ejemplo más básico de <acronym title="Test Driven Development">TDD</acronym>.

Sin embargo, una vez que tomamos mayor confianza en nuestro dominio del lenguaje o la programación misma, comenzamos a escribir cantidades cada vez mayores de código entre una comprobación y la siguiente del resultado. Como "sabemos" -en realidad, creemos- que nuestro código "esta bien", comenzamos a "optimizar el tiempo" escribiendo más y más código de una vez. Al poco tiempo, nos olvidamos de estas primeras experiencias, incluso tachándolas como "cosas de novatos".

## Aprendiendo <acronym title="Test Driven Development">TDD</acronym>

_Fast forward_ al presente y nos encontramos a nosotros mismos tratando de aprender <acronym title="Test Driven Development">TDD</acronym>. Nos conseguimos una copia de [JUnit][2], [NUnit][3], o el framework de moda para nuestro lenguaje de elección y comenzamos a seguir el tutorial que seguramente encontraremos en el sitio de este último. Los más afortunados probablemente tendrán integrada la funcionalidad directamente en su IDE.

A partir de aquí, estamos en la parte sencilla de nuestra curva de aprendizaje. En los próximos días comenzaremos a producir grandes cantidades de pruebas y no tardaremos en sentirnos cómodos con el proceso. Esto es lo más lejos que la mayoría llegamos en la curva y es aquí justamente donde comienzan los problemas.

Conforme comenzamos a intentar escribir pruebas para proyectos más complejos o incluso en el trabajo nos topamos con varios obstáculos en el camino:

- Las pruebas se tornan difíciles de escribir, por lo que sentimos una desaceleración importante.
- Corren lentamente, lo que nos volvemos renuentes a ejecutarlas frecuentemente.
- Son frágiles, por lo que cambios aparentemente sin importancia en el código provocan que un montón de pruebas fallen.
- Mantenerlas en forma y funcionando se vuelve complejo y consume tiempo.

Finalmente nos damos por vencido y abandonamos completamente nuestras mejores intenciones y pensamos "Simplemente no vale la pena".

Estamos en la parte más pronunciada de nuestra curva de aprendizaje. Tal vez estamos produciendo muchas pruebas, y estamos obteniendo verdadero valor de las mismas. Sin embargo el esfuerzo para escribir/mantener estas mismas parece desproporcionado. Sin embargo, como cualquier otra habilidad que valga la pena adquirir, si en lugar de rendirnos seguimos adelante, eventualmente aprenderemos a cruzar a la parte de nuestra gráfica donde la pendiente de la curva se invierte y comenzamos a escribir pruebas más efectivas con un menor esfuerzo y a cosechar los beneficios de nuestra perseverancia.

Aprender a escribir bien y de mantener las pruebas toma tiempo y práctica. El propósito de este _blog_ es, en parte para ayudar a acelerar un poco este proceso, de forma que no se tenga que escribir muchas pruebas basura, imposible de mantener antes de comenzar a ver la luz al final del túnel.

## Las reglas de <acronym title="Test Driven Development">TDD</acronym>

Robert C. Martin (también conocido como "Tío Bob"), es una de las autoridades en <acronym title="Test Driven Development">TDD</acronym>. En varias ocasiones ha descrito el proceso en base a tres simples reglas:

1. No está permitido escribir ningún código de producción sin tener una prueba que falle.
2. No está permitido escribir más código de prueba que el necesario para fallar (y no compilar es fallar).
3. No está permitido escribir más código de producción que el necesario para pasar su prueba unitaria.

Esto significa que antes de poder escribir cualquier código, debemos pensar en una prueba apropiada para él. Pero por la regla número dos, ¡tampoco podemos escribir mucho de dicha prueba! En realidad, debemos detenernos en el momento en que la prueba falla al compilar o falla un <tt>assert</tt> y comenzar a escribir código de producción. Pero por la regla número tres, tan pronto como la prueba pasa (o compila, según el caso), debemos dejar de escribir código y continuar escribiendo la prueba unitaria o pasar a la siguiente prueba.

Creo que esto se verá mejor con un pequeño ejemplo:

- Escribimos suficiente de nuestra primera prueba para que falle

    ```python
    import unittest
    class TestPrimeFactors(unittest.TestCase):
      def testPrimesOf_0(self):
          self.assertEquals([], factorsOf[])

    if __name__ == '__main__':
      main()
    ```

    ```
    ====================================================
    ERROR: testPrimesOf_0 (__main__.TestPrimeFactors)
    ----------------------------------------------------
    Traceback (most recent call last):
      File "<stdin>", line 3, in testPrimesOf_0
    NameError: global name 'factorsOf' is not defined
    ----------------------------------------------------
    Ran 1 test in 0.001s

    FAILED (errors=1)
    ```

- Podemos ver obtenemos el error _"NameError: global name 'factorsOf' is not defined"_. Esta es nuestra señal para detenernos y escribir la definición de <tt>factorsOf</tt>

    ```python
    def factorsOf(n):
      return []
    ```

    ```
    .
    ----------------------------------------------------
    Ran 1 test in 0.000s
    OK
    ```
- <tt>testPrimesOf_0</tt>pasa. Podemos continuar escribiendo código de prueba:
    
    ```python
    # def testPrimesOf_0(self):  <- Eliminado
    def testPrimesOf_0_to_1(self):
      self.assertEquals([], factorsOf())
      self.assertEquals([], factorsOf(1))
    ```

    ```
    .
    ----------------------------------------------------
    Ran 1 test in 0.000s
    OK
    ```
- Bien hasta aquí. Siguiente prueba:
    
    ```python
    def testPrimesOf_2(self):
        self.assertEquals([2], factorsOf(2))
    ```

    ```
    .F
    ====================================================
    FAIL: testPrimesOf_2 (__main__.TestPrimeFactors)
    ----------------------------------------------------
    Traceback (most recent call last):
      File "~/blog/tdd-rules.py", line 12, in testPrimesOf_2
        self.assertEquals([2], factorsOf(2))
    AssertionError: Lists differ: [2] != []
    ----------------------------------------------------
    Ran 2 tests in 0.029s
    FAILED (failures=1)
    ```
- Ahora <tt>testPrimesOf_2</tt> falla. Hora de escribir código:
    
    ```python
    def factorsOf(n):
      if n > 1:
          return [n]
      return []
    ```

    ```
    .
    ----------------------------------------------------
    Ran 2 tests in 0.000s
    OK
    ```
- testPrimesOf_2</tt> pasa. Siguiente prueba:
    
    ```python
    # def testPrimesOf_2(self): <- eliminado
    def testPrimesOf_2_to_3(self):
        self.assertEquals([2], factorsOf(2))
        self.assertEquals([3], factorsOf(3))
    ```

    ```
    .
    ----------------------------------------------------
    Ran 2 tests in 0.000s
    OK
    ```
- También pasa sin modificación. Pasamos a la siguiente prueba:
    
    ```python
    def testPrimesOf_2_to_4(self):
        self.assertEquals([2], factorsOf(2))
        self.assertEquals([3], factorsOf(3))
        self.assertEquals([2, 2], factorsOf(4))
    ```

    ```
    .F
    ====================================================
    FAIL: testPrimesOf_2_to_4 (__main__.TestPrimeFactors)
    ----------------------------------------------------
    Traceback (most recent call last):
      File "~/blog/tdd-rules.py", line 16, in testPrimesOf_2_to_4
        self.assertEquals([2,2], factorsOf(4))
    AssertionError: Lists differ: [2, 2] != [4]
    ----------------------------------------------------
    Ran 2 tests in 0.001s
    FAILED (failures=1)
    ```
- Falla de nuevo. Hora de modificar el código de nuevo:
    
    ```python
    def factorsOf(n):
      result, factor = [], 2
      # if n > 1: <- Eliminado
      while n > 1:
          # return [n]  <- Eliminado
          while n % factor == :
              result.append(factor)
              n /= factor
          factor += 1
      # return []  <- Eliminado
      return result
    ```

    ```
    .
    ----------------------------------------------------
    Ran 2 tests in 0.000s
    OK
    ```

- Pasa.
  
Obviamente he resumido el proceso un poco debido a limitaciones de espacio, pero creo que el proceso es claro.

Podemos ver que en realidad nunca escribimos mucho código de una sola vez. ¡Y de eso se trata precisamente! Es mucho muy similar al proceso descrito al principio de este post, cuando probábamos nuestro código interactivamente en el intérprete. Una iteración completa por todo el ciclo toma solo unos segundos o máximo un par de minutos. La retroalimentación se mantiene alta y esto nos motiva a seguir adelante con confianza y determinación. ¿Porqué? Simple: en todo momento, si seguimos este proceso durante todo el día, sabemos que nuestro sistema está funcionando. Incluso si comentemos un error <em>hace solo un momento el sistema funcionaba correctamente</em>. Si introducimos un bug, único que hace falta es oprimir <tt>Ctrl-Z</tt> unas cuantas veces y podremos regresar a nuestra barra verde. Y creo firmemente que eso es algo valioso.

Uno de los problemas fundamentales a los que me he enfrentado a través de los años al desarrollar software, es el no entender bien lo que estoy haciendo en un momento dado. Hay veces que simplemente estoy tratando de entender una nueva API o sistema y debo escribir código para implementar nueva funcionalidad. Así que copio y pego código que encuentro en algún libro o sitio de internet y trato de hacerlo funcionar. Un cambio aquí, otro allá hasta que aparentemente funciona. El problema es que no entiendo lo que acabo de hacer. Si el código falla en QA o incluso un par de semanas después de haberlo escrito, realmente no tengo mucha idea de porqué. De hecho, no tengo idea de porqué funcionó cuando lo puse ahí en primer lugar.

Al seguir de forma disciplinada estas tres simples reglas, nunca paso demasiado tiempo sin saber si lo que hago funciona o no. Y como nunca escribo demasiado código, puedo entender plenamente cómo y porqué funciona.

### Escribiendo pruebas unitarias efectivas

Roy Osherove en [_The Art of Unit Testing_][4] dice que las buenas pruebas tienen tres propiedades comunes: son legibles, confiables y fáciles de mantener. Una cuarta propiedad que yo agregaría es &#8220;rapidez&#8221;, por razones que discutiremos más adelante.

### Legibilidad

Una prueba legible es aquella que revela su propósito o razón de ser de forma clara. Básicamente, qué es lo que la prueba ha de demostrar. Una parte importante de la legibilidad de una prueba consiste simplemente en darle un nombre apropiado. Si está probando una pila, por ejemplo, entonces no llamemos nuestras pruebas <tt>testStack_01</tt>, <tt>testStack_02</tt>, etc. No solo son nombres bobos (por decir lo menos) sino que lo único que revelan es que en alguna parte debe haber algún objeto o función llamado &#8220;Stack&#8221; involucrado. En cambio, elegir nombres que reflejen el comportamiento útil observable que el código debiera exhibir. Por ejemplo, <tt>testElementosGuardadosSonRegresadosEnOrdenInverso</tt> es un nombre que describe un comportamiento observable de las pilas: los elementos colocados al principio son los últimos en ser devueltos.

Es conveniente considerar que los nombres de las pruebas forman parte de la documentación del comportamiento de la <em>Unidad de Código Bajo Prueba</em>. Cuando llega el momento de implementar una nueva clase, a menudo encuentro útil comenzar con una lista inicial de las pruebas que quiero escribir (no siempre lo hago, pero a veces resulta indispensable). Puedo usar esta lista como un primer borrador de la especificación de la clase en cuestión, por ejemplo:

- No debe ser posible crear una <em>flootsam</em> sin una <em>jetsam</em> asociada.
- Si la <em>flootsam</em> no es persistente, no puede contener hijos.
- Una <em>flootsam</em> con hijos no puede ser cancelada.
- etc.

Esta lista más adelante puede convertirse en la base de los nombres de nuestras pruebas.

Cuando las pruebas llevan el nombre de una conducta observable, esta tiende naturalmente a reflejar unicamente este aspecto del código. Es aceptable tener más de un <tt>assert</tt>, siempre que estos se refieran a una sola cosa, generalmente a un solo objeto.

Encontrar el justo equilibrio entre tener el código de inicialización dentro de las pruebas, en una fábrica o en un método <tt>setup</tt> dedicado, es también un elemento importante de la legibilidad. Es importante reducir el volumen del código en las pruebas, pero también queremos que sea evidente lo que la prueba está haciendo. Es fácil caer en la trampa de ocultar muchos detalles en los métodos de inicialización o de fábrica, por lo que un lector tiene que buscar estos métodos para poder entender la prueba. El principio <acronym title="Don't Repeat Yourself">DRY</acronym>, a veces se encuentra firmemente grabado en la consciencia de los buenos programadores. Sin embargo, es perfectamente aceptable tener un poco más de redundancia, mientras que el propósito se mantenga claro.

Esto último no quiere decir que podemos ignorar las reglas y escribir nuestras pruebas de forma descuidada. Nuestras pruebas son parte esencial de nuestro código. Son tan importantes como el código de producción (o de acuerdo con Robert C. Martin, son aún más importantes). Por lo tanto es necesario poner tanto esmero en su manufactura como el que pondríamos en la demo que haremos la próxima semana frente al cliente.

### Confiabilidad

Una prueba confiable es la que falla o pasa de forma determinista. Las pruebas que dependen si la computadora está configurada correctamente, o cualquier otro tipo de variables externas, no son confiables, porque no es posible saber si una falla significa que el equipo no está configurado correctamente, o si el código contiene errores.

Estas pruebas que dependen de variables externas son en realidad pruebas de integración, y se deben poner en un proyecto por separado, junto con alguna documentación sobre la forma de ponerse en marcha. Esto es deseable, ya que este tipo de pruebas normalmente se ejecutan mucho más lentamente que las pruebas unitarias típicas, por lo que al estar separadas, no impedirán que ejecutemos nuestras pruebas unitarias tan frecuentemente como deseemos/necesitemos.

Una variable externa es cualquier cosa sobre la que no tenemos control directo: el sistema de archivos, bases de datos, el tiempo, el código de terceros, etc.

En cuanto al tiempo, basta con crear algunas instancias tipo fecha con un instante fijo, en lugar un indeterminado &#8220;tiempo actual&#8221; y olvidarnos del asunto. En una prueba unitaria, deberíamos utilizar exactamente los mismos datos de prueba cada vez, pero si la prueba dependiera de un valor como <tt>DateTime.Now</tt>, entonces efectivamente sería una prueba diferente cada vez que se ejecute.

En algunas ocasiones especiales, es imposible evitar el tener una prueba indeterminable sin importar cuanto nos esforcemos. Martin Fowler y otros recomiendan en primer lugar, aislar estas pruebas. Lo último que queremos es acostumbrarnos a ver fallar pruebas en nuestra suite. Una barra roja para nosotros siempre debe ser una señal de alarma. No importa que podamos reconocer la prueba por su nombre. El punto de usar pruebas automáticas es precisamente no tener que inspeccionar visualmente los resultados para darlos o no por buenos. Si esto sucede, ¡podemos pasar por alto un fallo real sin notarlo! Otro punto es el analizar si una aproximación probabilística es útil en estos casos. Si los resultados de la prueba se encuentran acotados dentro de un margen de tolerancia, es posible eliminar la incertidumbre hasta un grado aceptable para nuestros propósitos.

### Mantenibilidad

Una prueba fácil de mantener es aquella que no &#8220;se rompe&#8221; fácilmente cuando se les da mantenimiento. Un bajo acoplamiento es probablemente el factor más importante para la facilidad de mantenimiento. El uso de <em>Métodos de fábrica</em> nos permite desacoplar nuestras pruebas de los constructores de clase, que tienden sufrir cambios en sus listas de parámetros más a menudo que otros métodos.

Dar nombres significativos a nuestras pruebas también es importante para el mantenimiento, así como la legibilidad. Cuando se puede deducir a partir del nombre lo que la prueba está tratando de comprobar, se puede ver si en realidad el código hace lo que se dice que está haciendo. Puede asegurarse que las pruebas mantienen su comportamiento, incluso cuando hay cambios en el API que utiliza.

Cuando las pruebas se pueden leer, entonces se vuelven más fáciles de mantener. Cuando las pruebas se pueden mantener, entonces es probable que en de hecho, se les dé mantenimiento. Cuando se sabe que las pruebas se mantienen, y se puede inferir lo que están comprobando, entonces es posible confiar en ellas como en la red de seguridad que se supone que son.

## Rapidez

Una prueba unitaria efectiva debería ejecutarse en milisegundos, <strong>no en segundos</strong>. Si a una prueba tarda más que algunos cientos de milisegundos en ejecutar, es probable que debamos considerarla demasiado lenta. Como en todo, hay excepciones, pero esta es una buena regla a seguir. A continuación explico porqué.

Una suite de pruebas puede llegar a contener decenas o incluso cientos de pruebas, organizadas en clases, cada una enfocándose a un aspecto particular del código. Si una prueba se ejecuta en un segundo (1000 milisegundos) y tenemos cien de ellas, tendremos que esperar más de dos minutos para conocer el resultado de las mismas. Correr la suite se convierte en si mismo en una interrupción que altera nuestro ritmo de trabajo: La mente se distrae y para cuando finalmente tenemos los resultados, debemos de &#8220;vaciar la pila&#8221; nuevamente y reingresar el contexto que teníamos unos segundos antes de ejecutar la suite.

Si hacemos esto una y otra vez en el transcurso del día (a la mayoría de los desarrolladores se les complica mantener su atención por más de algunos segundos antes de perder el interés), entonces comenzaremos a evitar el correr nuestras pruebas, lo cual deberíamos hacer cada vez que cambiamos &#8220;algo&#8221; en el código. Y si esto es así, entonces perdemos la confianza en nuestros cambios y en nosotros mismos. Regresamos al ritmo &#8220;tradicional&#8221; y finalmente puede llegar a parecernos &#8220;más fácil&#8221; abrir el depurador de nuestro IDE que dar un par de pasos hacia atrás hasta el punto en que todo aun funcionaba bien.

Todo ello sin considerar el tiempo perdido. No solo el tiempo de ejecución de las pruebas mismas, sino el tiempo que nos toma volver a entrar en el contexto mental que teníamos justo antes.

Una sesión de <acronym title="Test Driven Development">TDD</acronym> en realidad debería transcurrir como los ejemplos interactivos al principio de este post. Escribimos algo de código y deberíamos obtener retroalimentación casi inmediatamente. Cada vez que corremos la suite &#8220;en verde&#8221;, aumenta nuestra confianza, en nuestro código, en nuestra suite y en nosotros mismos, lo cual nos mantiene altamente motivados para seguir adelante.

Volver al ciclo tradicional de modificar/compilar/debuguear destruye esa motivación. Si probar un cambio de una sola linea nos lleva 5 minutos de en el depurador, nuestra motivación se va a los suelos y se convierte en una excusa para alargar los tiempos de desarrollo casi infinitamente.

Un componente fundamental en la construcción de una suite de pruebas es la habilidad de construirla a partir de subconjuntos más pequeños y enfocados. Es importante ser capaz de probar el sistema completo oprimiendo solo un botón (o con un solo comando en la shell del sistema), pero igualmente importante es poder ejecutar únicamente las pruebas para la clase o el sub-sistema que estamos probando en este momento. La mayoría de los frameworks de la familia XUnit tienen esta capacidad. Se pueden crear suites pequeñas y estas a su vez, incluirlas en suites mayores.

## Cookbook

### Aprender

- Escribe muchas pruebas (tantas como puedas). Familiarizate con el ritmo y las reglas de <acronym title="Test Driven Development">TDD</acronym>. Comienza con algo sencillo (¡pero no te detengas ahí!)
- Cuando encuentres algo que no sabes como probar, apóyate en un compañero. Si no programas en parejas, consulta con un colega. Recolecta ideas de diversas fuentes.
- Sé persistente y no te rindas. Si quieres obtener los frutos, debes primero poner el trabajo duro.
- Nunca dejes de aprender. Lee libros (una lista al final de este post), blogs, revistas, etc. Los proyectos de <em>Código Abierto</em> son una excelente fuente de aprendizaje.
- Conforme escribas más y más pruebas, comienza a organizarlas en suites y asegúrate que estas puedan ejecutarse de forma individual o colectiva, según sea necesario. ¡La organización también es una habilidad que hay que aprender!

### Prácticas para el día a día

- Es recomendable probar una unidad de código solo a través de su _API_ pública (y en términos prácticos, "protegido"; es efectivamente público). Al hacer esto, obtenemos un mejor aislamiento de los detalles específicos de la implementación.
- Evita a toda cosa colocar lógica en el código de prueba (<tt>if</tt>-<tt>then</tt>, <tt>switch</tt>/<tt>case</tt>, etc). Donde hay lógica, hay la probabilidad de introducir _bugs_, ¡y definitivamente no queremos _bugs_ en nuestras pruebas!
- Evita los <em>&#8220;números mágicos&#8221;</em>. Esto te permitirá entender porqué en una prueba particular un método regresa un valor dado o porque se pasa un cierto valor como parámetro y no otro diferente.
- Evita calcular el valor esperado, ya que podríamos terminar duplicando el código del producción, incluyendo cualquier error que este pudiera tener. Preferiblemente, calcula el resultado esperado manualmente (y revisalo por lo menos un par de veces) y colócalo como una constante.
- Evita compartir estado entre pruebas. Debe ser posible ejecutar las pruebas en cualquier orden o incluso, ejecutar una prueba dentro de otra prueba. Mantener las pruebas aisladas de las demás también es un factor indispensable para la confiabilidad y mantenibilidad de las mismas.
- Sin importar como lo veas, ninguna cantidad de comentarios puede sustituir un código claro. Si una prueba se convierte en un desastre, reescríbela.
- Si no es posible determinar lo que una prueba está haciendo, es probable que en realidad esté verificando múltiples cosas: hazla pedazos y convierte cada uno en su propia prueba individual.
- Frecuentemente los errores en el código de pruebas se esconden en los métodos de inicialización. Mantener este código simple y compacto puede ser un gran paso para la mantenibilidad del código.
- Una unidad de código puede necesitar operar en circunstancias escenarios variables. Esto puede llevar a que el código de inicialización se convierta rápidamente en un desastre. Crea <tt>fixtures</tt> o incluso casos de prueba especializados para cada escenario.
- Nunca escatimes en claridad. Si es necesario, convierte cada escenario en una clase de prueba individual.
- Si al probar una parte de tu código parece que requieres tener la mitad o más del sistema presente, verifica el alcance de la misma. ¿Estás probando una sola cosa?
- Si una parte del código es particularmente resistente a tus esfuerzos de probarla, voltea al código en busca de problemas en el diseño del mismo. Un código fácil de probar frecuentemente está débilmente acoplado con el resto del sistema, es altamente cohesivo y sigue los principios fundamentales del diseño de software.


Espero como siempre que haya sido de utilidad.


 [1]: http://xprogramming.com/
 [2]: http://junit.org/
 [3]: http://www.nunit.org/
 [4]: http://www.manning.com/osherove/
