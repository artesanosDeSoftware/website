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
---

## Introducción

Esta es mi primera contribución para _Artesanos de Software_.

Soy un desarrollador de software "de la vieja escuela", por decirlo de alguna manera. Hace años, pensaba que tenía bastante dominado este asunto de la programación, hasta que me topé con [_Extreme Programming_][1]</a> y todo el ecosistema de Métodos Ágiles que se ha desarrollado desde entonces. Para mi, todo cambió desde entonces y me dí cuenta de lo poco que sé en realidad. He estado practicando la disciplina del Desarrollo Dirigido por Pruebas o <acronym title="Test Driven Development">TDD</acronym> ahora si y ahora no por los últimos ocho años. Quienes me conozcan, sabrán que no ha sido ni por mucho un proceso fácil ni mucho menos rápido. Sin embargo, si solo pudiera lograr que todos los desarrolladores de mi equipo adoptaran una sola práctica de <acronym title="Extreme Programming">XP</acronym>, esa sería <acronym title="Test Driven Development">TDD</acronym>.

<div>
  
  
  <p>
    Las excusas abundan, es simplemente demasiado fácil ceder y dejar de hacerlo. Desde los clásicos <em>&#8220;en mi empresa no me lo permiten&#8221;</em> y <em>&#8220;mi jefe dice que me pagan por escribir funcionalidad, no pruebas&#8221;</em> hasta los no tan infrecuentes <em>&#8220;las pruebas son trabajo de QA, no mio&#8221;</em> o <em>&#8220;esta porquería es una mi3rd@, ¡es imposible de probar!&#8221;</em>. Lo sé porque yo mismo he estado en esas situaciones, he dado las mismas excusas y ni una sola vez puedo decir que el resultado haya sido positivo para mi o para el proyecto.
  </p>
  
  <p>
    El propósito de este blog es allanar un poco el camino para aquellos que estén considerando aprender <acronym title="Test Driven Development">TDD</acronym> y posiblemente utilizarlo en su trabajo o en proyectos personales. Para mi no ha sido fácil y aún estoy aprendiendo. Si alguien puede sacar algo en claro de mis propias experiencias pasadas, creo que eso será más que suficiente para compensar el tiempo invertido en el mismo.
  </p>
  
  <p>
    Este blog debe considerarse un trabajo en progreso. La idea del mismo comenzó hace probablemente tres o cuatro meses. Simplemente hay demasiados temas y ángulos para cubrir de una sola vez. El material disponible en la red, las anécdotas personales, las técnicas, los &#8220;pitfalls&#8221; (alguien, español por favor?), los &#8220;tips&#8221;, etc. son suficientes como para llenar uno o varios libros así que no puedo esperar cubrir todas las bases en un solo post. Debido a ello, en este post me concentraré exclusivamente en el tema de las pruebas unitarias. Solo el tiempo dirá si soy capaz de llevar este proyecto a buen término <tt><img src="http://artesanos.de/software/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley" /></tt>
  </p>
</div>

<div>
  <h2>
    ¿Qué es <acronym title="Test Driven Development">TDD</acronym>?
  </h2>
  
  <p>
    <acronym title="Test Driven Development">TDD</acronym> es una criatura extraña. Es simple de definir, pero su definición parece ir en contra del sentido común. Es sencilla de explicar, pero difícil de llevar a cabo. Y una vez que superas la resistencia intelectual inicial (the &#8220;<acronym title="¿Qué carajos?">WTF</acronym> factor&#8221;) y lo entiendes, es difícil de dominar.
  </p>
  
  <dl>
    <dt>
      Definición:
    </dt>
    
    <dd>
      Es una disciplina que promueve el desarrollo de software con altos niveles de calidad, simplicidad de diseño y productividad del programador, mediante la utilización de una amplia gama de tipos de pruebas automáticas a lo largo de todo el ciclo de vida del software. El principio fundamental es que las pruebas se escriben antes que el software de producción y estas constituyen la especificación objetiva del mismo.
    </dd>
  </dl>
  
  <p>
    La primera parte de la definición suena todo miel sobre hojuelas. ¿Quién no quiere software confiable, bien diseñado y producido rápidamente?. Sin embargo, todo esto no viene gratuitamente; la palabra clave aquí es <em>disciplina</em>.
  </p>
  
  <dl>
    <dt>
      Disciplina:
    </dt>
    
    <dd>
      Doctrina, instrucción de una persona, especialmente en lo moral. Observancia de las leyes y ordenamientos de la profesión o instituto.
    </dd>
  </dl>
  
  <p>
    Esto nos lleva a la conclusión de que si <acronym title="Test Driven Development">TDD</acronym> es en efecto una disciplina, entonces no es algo que aplicamos &#8220;según nos vayamos sintiendo&#8221;, más bien, es algo que debe formar parte integral de nuestra profesión o arte (según la perspectiva de cada quien).
  </p>
  
  <p>
    La segunda parte de la definición viene con el primer &#8220;<acronym title="¿Qué carajos?">WTF</acronym>&#8221; para muchos: Las pruebas se deben escribir <em>antes</em> que el software mismo. La primera impresión de muchos (incluyendo a <em>yours truely</em>) es &#8220;¿eh?, ¿y cómo demonios escribo una prueba para software que todavía no existe?&#8221;.
  </p>
  
  <p>
    Cuando aprendemos a programar, los más afortunados comienzan con algún lenguaje interpretado como Basic, Logo o Scheme (para los más veteranos) o Ruby y Python. Normalmente comenzamos con cosas simples como por ejemplo, sumar 2 y 3:
  </p>
  
  <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">&gt;&gt;&gt; 2 + 3
5</pre>
  
  <p>
    Intuitivamente pensamos <em>&#8220;debe dar cinco&#8221;</em>, incluso <em>antes</em> de oprimir la tecla <tt>ENTER</tt>; y normalmente funciona o si no, entonces hay algo definitivamente mal con el lenguaje o con nuestro entendimiento del mismo. Posteriormente pasamos a cosas más complejas y/o sofisticadas, como por ejemplo:
  </p>
  
  <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">&gt;&gt;&gt; a = 2
&gt;&gt;&gt; a + 3
5
&gt;&gt;&gt; b = 3
&gt;&gt;&gt; a + b
5
&gt;&gt;&gt; def sum(a, b):
...   return a + b
...
&gt;&gt;&gt; sum(2, 3)
5</pre>
  
  <p>
    Etcétera. Todo el tiempo verificamos que el resultado es el que esperamos, aunque &#8220;sabemos&#8221; que así debería ser. Cada vez que vemos el resultado que esperamos aparecer en la pantalla, aumenta nuestra autoconfianza, lo que nos motiva a seguir aprendiendo, a seguir programando. Este podría tal vez ser el ejemplo más básico de <acronym title="Test Driven Development">TDD</acronym>.
  </p>
  
  <p>
    Sin embargo, una vez que tomamos mayor confianza en nuestro dominio del lenguaje o la programación misma, comenzamos a escribir cantidades cada vez mayores de código entre una comprobación y la siguiente del resultado. Como &#8220;sabemos&#8221; &#8211;en realidad, creemos&#8211; que nuestro código &#8220;esta bien&#8221;, comenzamos a &#8220;optimizar el tiempo&#8221; escribiendo más y más código de una vez. Al poco tiempo, nos olvidamos de estas primeras experiencias, incluso tachándolas como &#8220;cosas de novatos&#8221;.
  </p>
</div>

<div>
  <h2>
    Aprendiendo <acronym title="Test Driven Development">TDD</acronym>
  </h2>
  
  <p>
    Fast forward al presente y nos encontramos a nosotros mismos tratando de aprender <acronym title="Test Driven Development">TDD</acronym>. Nos conseguimos una copia de <a href="http://junit.org/" target="_blank">JUnit</a>, <a href="http://www.nunit.org/" target="_blank">NUnit</a>, o el framework de moda para nuestro lenguaje de elección y comenzamos a seguir el tutorial que seguramente encontraremos en el sitio de este último. Los más afortunados probablemente tendrán integrada la funcionalidad directamente en su IDE.
  </p>
  
  <p>
    A partir de aquí, estamos en la parte sencilla de nuestra curva de aprendizaje. En los próximos días comenzaremos a producir grandes cantidades de pruebas y no tardaremos en sentirnos cómodos con el proceso. Esto es lo más lejos que la mayoría llegamos en la curva y es aquí justamente donde comienzan los problemas.
  </p>
  
  <p>
    Conforme comenzamos a intentar escribir pruebas para proyectos más complejos o incluso en el trabajo nos topamos con varios obstáculos en el camino:
  </p>
  
  <ul>
    <li>
      Las pruebas se tornan difíciles de escribir, por lo que sentimos una desaceleración importante.
    </li>
    <li>
      Corren lentamente, lo que nos volvemos renuentes a ejecutarlas frecuentemente.
    </li>
    <li>
      Son frágiles, por lo que cambios aparentemente sin importancia en el código provocan que un montón de pruebas fallen.
    </li>
    <li>
      Mantenerlas en forma y funcionando se vuelve complejo y consume tiempo.
    </li>
  </ul>
  
  <p>
    Finalmente nos damos por vencido y abandonamos completamente nuestras mejores intenciones y pensamos &#8220;Simplemente no vale la pena&#8221;.
  </p>
  
  <p>
    Estamos en la parte más pronunciada de nuestra curva de aprendizaje. Tal vez estamos produciendo muchas pruebas, y estamos obteniendo verdadero valor de las mismas. Sin embargo el esfuerzo para escribir/mantener estas mismas parece desproporcionado. Sin embargo, como cualquier otra habilidad que valga la pena adquirir, si en lugar de rendirnos seguimos adelante, eventualmente aprenderemos a cruzar a la parte de nuestra gráfica donde la pendiente de la curva se invierte y comenzamos a escribir pruebas más efectivas con un menor esfuerzo y a cosechar los beneficios de nuestra perseverancia.
  </p>
  
  <p>
    Aprender a escribir bien y de mantener las pruebas toma tiempo y práctica. El propósito de este blog es, en parte para ayudar a acelerar un poco este proceso, de forma que no se tenga que escribir muchas pruebas basura, imposible de mantener antes de comenzar a ver la luz al final del túnel.
  </p>
</div>

<div>
  <h2>
    Las reglas de <acronym title="Test Driven Development">TDD</acronym>
  </h2>
  
  <p>
    Robert C. Martin (también conocido como &#8220;Tío Bob&#8221;), es una de las autoridades en <acronym title="Test Driven Development">TDD</acronym>. En varias ocasiones ha descrito el proceso en base a tres simples reglas:
  </p>
  
  <ol>
    <li>
      No está permitido escribir ningún código de producción sin tener una prueba que falle.
    </li>
    <li>
      No está permitido escribir más código de prueba que el necesario para fallar (y no compilar es fallar).
    </li>
    <li>
      No está permitido escribir más código de producción que el necesario para pasar su prueba unitaria.
    </li>
  </ol>
  
  <p>
    Esto significa que antes de poder escribir cualquier código, debemos pensar en una prueba apropiada para él. Pero por la regla número dos, ¡tampoco podemos escribir mucho de dicha prueba! En realidad, debemos detenernos en el momento en que la prueba falla al compilar o falla un <tt>assert</tt> y comenzar a escribir código de producción. Pero por la regla número tres, tan pronto como la prueba pasa (o compila, según el caso), debemos dejar de escribir código y continuar escribiendo la prueba unitaria o pasar a la siguiente prueba.
  </p>
  
  <p>
    Creo que esto se verá mejor con un pequeño ejemplo:
  </p>
  
  <ul>
    <li>
      Escribimos suficiente de nuestra primera prueba para que falle <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em"><span style="color: #606">import</span> unittest

<span style="color: #606">class</span> <span style="color: teal">TestPrimeFactors</span><span style="color: #606">(</span>unittest.TestCase<span style="color: #606">):</span>

    <span style="color: #606">def</span> <span style="color: teal">testPrimesOf_0</span><span style="color: #606">(</span>self<span style="color: #606">):</span>
        self.assertEquals<span style="color: #606">([],</span> factorsOf<span style="color: #606">[</span><span style="color: #c00"></span><span style="color: #606">])</span>

<span style="color: #606">if</span> __name__ <span style="color: #606">==</span> <span style="color: navy">'__main__'</span><span style="color: #606">:</span>
    main<span style="color: #606">()</span></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">E
======================================================================
ERROR: testPrimesOf_0 (__main__.TestPrimeFactors)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "&lt;stdin&gt;", line 3, in testPrimesOf_0
NameError: global name 'factorsOf' is not defined

----------------------------------------------------------------------
Ran 1 test in 0.001s

<span style="color: red">FAILED (errors=1)</span></pre>
    </li>
    
    <li>
      Podemos ver obtenemos el error &#8220;NameError: global name &#8216;factorsOf&#8217; is not defined&#8221;. Esta es nuestra señal para detenernos y escribir la definición de <tt>factorsOf</tt>: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em"><span style="color: #606">def</span> <span style="color: teal">factorsOf</span><span style="color: #606">(</span>n<span style="color: #606">):</span>
    <span style="color: #606">return []</span></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">.
----------------------------------------------------------------------
Ran 1 test in 0.000s

<span style="color: lime">OK</span></pre>
    </li>
    
    <li>
      <tt>testPrimesOf_0</tt>pasa. Podemos continuar escribiendo código de prueba: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em">    <span style="text-decoration: line-through"><span style="color: #606">def</span> <span style="color: teal">testPrimesOf_0</span><span style="color: #606">(</span>self<span style="color: #606">):</span></span>
    <span style="color: #606">def</span> <strong><span style="color: teal">testPrimesOf_0_to_1</span></strong><span style="color: #606">(</span>self<span style="color: #606">):</span>
        self.assertEquals<span style="color: #606">([],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00"></span><span style="color: #606">))</span>
        <strong>self.assertEquals<span style="color: #606">([],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00">1</span><span style="color: #606">))</span></strong></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">.
----------------------------------------------------------------------
Ran 1 test in 0.000s

<span style="color: lime">OK</span></pre>
    </li>
    
    <li>
      Bien hasta aquí. Siguiente prueba: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em">    <span style="color: #606">def</span> <span style="color: teal">testPrimesOf_2</span><span style="color: #606">(</span>self<span style="color: #606">):</span>
        self.assertEquals<span style="color: #606">([</span>2<span style="color: #606">],</span> factorsOf<span style="color: #606">(</span>2<span style="color: #606">))</span></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">.F
======================================================================
FAIL: testPrimesOf_2 (__main__.TestPrimeFactors)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "~/blog/tdd-rules.py", line 12, in testPrimesOf_2
    self.assertEquals([2], factorsOf(2))
AssertionError: Lists differ: [2] != []

----------------------------------------------------------------------
Ran 2 tests in 0.029s

<span style="color: red">FAILED (failures=1)</span></pre>
    </li>
    
    <li>
      Ahora <tt>testPrimesOf_2</tt>falla. Hora de escribir código: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em"><span style="color: #606">def</span> factorsOf<span style="color: #606">(</span>n<span style="color: #606">):</span>
    <strong><span style="color: #606">if</span> n <span style="color: #606">&gt;</span> <span style="color: #c00">1</span><span style="color: #606">:</span></strong>
        <strong><span style="color: #606">return [</span>n<span style="color: #606">]</span></strong>
    <span style="color: #606">return []</span></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">..
----------------------------------------------------------------------
Ran 2 test in 0.000s

<span style="color: lime">OK</span></pre>
    </li>
    
    <li>
      <tt>testPrimesOf_2</tt>pasa. Siguiente prueba: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em">    <span style="text-decoration: line-through"><span style="color: #606">def</span> <span style="color: teal">testPrimesOf_2</span><span style="color: #606">(</span>self<span style="color: #606">):</span></span>
    <span style="color: #606">def</span> <strong><span style="color: teal">testPrimesOf_2_to_3</span></strong><span style="color: #606">(</span>self<span style="color: #606">):</span>
        self.assertEquals<span style="color: #606">([</span><span style="color: #c00">2</span><span style="color: #606">],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00">2</span><span style="color: #606">))</span>
        <strong>self.assertEquals<span style="color: #606">([</span><span style="color: #c00">3</span><span style="color: #606">],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00">3</span><span style="color: #606">))</span></strong></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">..
----------------------------------------------------------------------
Ran 2 test in 0.000s

<span style="color: lime">OK</span></pre>
    </li>
    
    <li>
      También pasa sin modificación. Pasamos a la siguiente prueba: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em">    <span style="color: #606">def</span> <span style="color: teal">testPrimesOf_2_to_4</span><span style="color: #606">(</span>self<span style="color: #606">):</span>
        self.assertEquals<span style="color: #606">([</span><span style="color: #c00">2</span><span style="color: #606">],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00">2</span>))
        self.assertEquals<span style="color: #606">([</span><span style="color: #c00">3</span><span style="color: #606">],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00">3</span>))
        <strong>self.assertEquals<span style="color: #606">([</span><span style="color: #c00">2</span><span style="color: #606">,</span> <span style="color: #c00">2</span><span style="color: #606">],</span> factorsOf<span style="color: #606">(</span><span style="color: #c00">4</span><span style="color: #606">))</span></strong></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">.F
======================================================================
FAIL: testPrimesOf_2_to_4 (__main__.TestPrimeFactors)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "~/blog/tdd-rules.py", line 16, in testPrimesOf_2_to_4
    self.assertEquals([2,2], factorsOf(4))
AssertionError: Lists differ: [2, 2] != [4]

----------------------------------------------------------------------
Ran 2 tests in 0.001s

<span style="color: red">FAILED (failures=1)</span></pre>
    </li>
    
    <li>
      Falla de nuevo. Hora de modificar el código de nuevo: <pre style="border: solid blue 1px;background-color: #ddf;padding: 3pt 1em"><span style="color: #606">def</span> factorsOf(n<span style="color: #606">):</span>
    <strong>result<span style="color: #606">,</span> factor</strong> <span style="color: #606">= []</span><strong><span style="color: #606">,</span> <span style="color: #c00">2</span></strong>
    <span style="text-decoration: line-through"><span style="color: #606">if</span> n <span style="color: #606">&gt;</span> <span style="color: #c00">1</span>:</span>
    <strong><span style="color: #606">while</span></strong> n <span style="color: #606">&gt;</span> <span style="color: #c00">1</span><span style="color: #606">:</span>
        <span style="text-decoration: line-through"><span style="color: #606">return [</span>n<span style="color: #606">]</span></span>
        <strong><span style="color: #606">while</span> n <span style="color: #606">%</span> factor <span style="color: #606">==</span> <span style="color: #c00"></span>:</strong>
            <strong>result.append<span style="color: #606">(</span>factor<span style="color: #606">)</span></strong>
            <strong>n <span style="color: #606">/=</span> factor</strong>
        <strong>factor <span style="color: #606">+=</span> <span style="color: #c00">1</span></strong>
    <span style="text-decoration: line-through"><span style="color: #606">return []</span></span>
    <strong><span style="color: #606">return</span> result</strong></pre>
      
      <pre style="background-color: black;color: silver;border: double silver 3px;padding: 3pt 1em">..
----------------------------------------------------------------------
Ran 2 test in 0.000s

<span style="color: lime">OK</span></pre>
    </li>
    
    <li>
      Pasa.
    </li>
  </ul>
  
  <p>
    Obviamente he resumido el proceso un poco debido a limitaciones de espacio, pero creo que el proceso es claro.
  </p>
  
  <p>
    Podemos ver que en realidad nunca escribimos mucho código de una sola vez. ¡Y de eso se trata precisamente! Es mucho muy similar al proceso descrito al principio de este post, cuando probábamos nuestro código interactivamente en el intérprete. Una iteración completa por todo el ciclo toma solo unos segundos o máximo un par de minutos. La retroalimentación se mantiene alta y esto nos motiva a seguir adelante con confianza y determinación. ¿Porqué? Simple: en todo momento, si seguimos este proceso durante todo el día, sabemos que nuestro sistema está funcionando. Incluso si comentemos un error <em>hace solo un momento el sistema funcionaba correctamente</em>. Si introducimos un bug, único que hace falta es oprimir <tt>Ctrl-Z</tt> unas cuantas veces y podremos regresar a nuestra barra verde. Y creo firmemente que eso es algo valioso.
  </p>
  
  <p>
    Uno de los problemas fundamentales a los que me he enfrentado a través de los años al desarrollar software, es el no entender bien lo que estoy haciendo en un momento dado. Hay veces que simplemente estoy tratando de entender una nueva API o sistema y debo escribir código para implementar nueva funcionalidad. Así que copio y pego código que encuentro en algún libro o sitio de internet y trato de hacerlo funcionar. Un cambio aquí, otro allá hasta que aparentemente funciona. El problema es que no entiendo lo que acabo de hacer. Si el código falla en QA o incluso un par de semanas después de haberlo escrito, realmente no tengo mucha idea de porqué. De hecho, no tengo idea de porqué funcionó cuando lo puse ahí en primer lugar.
  </p>
  
  <p>
    Al seguir de forma disciplinada estas tres simples reglas, nunca paso demasiado tiempo sin saber si lo que hago funciona o no. Y como nunca escribo demasiado código, puedo entender plenamente cómo y porqué funciona.
  </p>
</div>

<div>
  <h2>
    Escribiendo pruebas unitarias efectivas
  </h2>
  
  <p>
    Roy Osherove en <a href="http://www.manning.com/osherove/" target="_blank"><em>The Art of Unit Testing</em></a> dice que las buenas pruebas tienen tres propiedades comunes: son legibles, confiables y fáciles de mantener. Una cuarta propiedad que yo agregaría es &#8220;rapidez&#8221;, por razones que discutiremos más adelante.
  </p>
  
  <div>
    <h3>
      Legibilidad
    </h3>
    
    <p>
      Una prueba legible es aquella que revela su propósito o razón de ser de forma clara. Básicamente, qué es lo que la prueba ha de demostrar. Una parte importante de la legibilidad de una prueba consiste simplemente en darle un nombre apropiado. Si está probando una pila, por ejemplo, entonces no llamemos nuestras pruebas <tt>testStack_01</tt>, <tt>testStack_02</tt>, etc. No solo son nombres bobos (por decir lo menos) sino que lo único que revelan es que en alguna parte debe haber algún objeto o función llamado &#8220;Stack&#8221; involucrado. En cambio, elegir nombres que reflejen el comportamiento útil observable que el código debiera exhibir. Por ejemplo, <tt>testElementosGuardadosSonRegresadosEnOrdenInverso</tt> es un nombre que describe un comportamiento observable de las pilas: los elementos colocados al principio son los últimos en ser devueltos.
    </p>
    
    <p>
      Es conveniente considerar que los nombres de las pruebas forman parte de la documentación del comportamiento de la <em>Unidad de Código Bajo Prueba</em>. Cuando llega el momento de implementar una nueva clase, a menudo encuentro útil comenzar con una lista inicial de las pruebas que quiero escribir (no siempre lo hago, pero a veces resulta indispensable). Puedo usar esta lista como un primer borrador de la especificación de la clase en cuestión, por ejemplo:
    </p>
    
    <ul>
      <li>
        No debe ser posible crear una <em>flootsam</em> sin una <em>jetsam</em> asociada.
      </li>
      <li>
        Si la <em>flootsam</em> no es persistente, no puede contener hijos.
      </li>
      <li>
        Una <em>flootsam</em> con hijos no puede ser cancelada.
      </li>
      <li>
        etc.
      </li>
    </ul>
    
    <p>
      Esta lista más adelante puede convertirse en la base de los nombres de nuestras pruebas.
    </p>
    
    <p>
      Cuando las pruebas llevan el nombre de una conducta observable, esta tiende naturalmente a reflejar unicamente este aspecto del código. Es aceptable tener más de un <tt>assert</tt>, siempre que estos se refieran a una sola cosa, generalmente a un solo objeto.
    </p>
    
    <p>
      Encontrar el justo equilibrio entre tener el código de inicialización dentro de las pruebas, en una fábrica o en un método <tt>setup</tt> dedicado, es también un elemento importante de la legibilidad. Es importante reducir el volumen del código en las pruebas, pero también queremos que sea evidente lo que la prueba está haciendo. Es fácil caer en la trampa de ocultar muchos detalles en los métodos de inicialización o de fábrica, por lo que un lector tiene que buscar estos métodos para poder entender la prueba. El principio <acronym title="Don't Repeat Yourself">DRY</acronym>, a veces se encuentra firmemente grabado en la consciencia de los buenos programadores. Sin embargo, es perfectamente aceptable tener un poco más de redundancia, mientras que el propósito se mantenga claro.
    </p>
    
    <p>
      Esto último no quiere decir que podemos ignorar las reglas y escribir nuestras pruebas de forma descuidada. Nuestras pruebas son parte esencial de nuestro código. Son tan importantes como el código de producción (o de acuerdo con Robert C. Martin, son aún más importantes). Por lo tanto es necesario poner tanto esmero en su manufactura como el que pondríamos en la demo que haremos la próxima semana frente al cliente.
    </p>
  </div>
  
  <div>
    <h3>
      Confiabilidad
    </h3>
    
    <p>
      Una prueba confiable es la que falla o pasa de forma determinista. Las pruebas que dependen si la computadora está configurada correctamente, o cualquier otro tipo de variables externas, no son confiables, porque no es posible saber si una falla significa que el equipo no está configurado correctamente, o si el código contiene errores.
    </p>
    
    <p>
      Estas pruebas que dependen de variables externas son en realidad pruebas de integración, y se deben poner en un proyecto por separado, junto con alguna documentación sobre la forma de ponerse en marcha. Esto es deseable, ya que este tipo de pruebas normalmente se ejecutan mucho más lentamente que las pruebas unitarias típicas, por lo que al estar separadas, no impedirán que ejecutemos nuestras pruebas unitarias tan frecuentemente como deseemos/necesitemos.
    </p>
    
    <p>
      Una variable externa es cualquier cosa sobre la que no tenemos control directo: el sistema de archivos, bases de datos, el tiempo, el código de terceros, etc.
    </p>
    
    <p>
      En cuanto al tiempo, basta con crear algunas instancias tipo fecha con un instante fijo, en lugar un indeterminado &#8220;tiempo actual&#8221; y olvidarnos del asunto. En una prueba unitaria, deberíamos utilizar exactamente los mismos datos de prueba cada vez, pero si la prueba dependiera de un valor como <tt>DateTime.Now</tt>, entonces efectivamente sería una prueba diferente cada vez que se ejecute.
    </p>
    
    <p>
      En algunas ocasiones especiales, es imposible evitar el tener una prueba indeterminable sin importar cuanto nos esforcemos. Martin Fowler y otros recomiendan en primer lugar, aislar estas pruebas. Lo último que queremos es acostumbrarnos a ver fallar pruebas en nuestra suite. Una barra roja para nosotros siempre debe ser una señal de alarma. No importa que podamos reconocer la prueba por su nombre. El punto de usar pruebas automáticas es precisamente no tener que inspeccionar visualmente los resultados para darlos o no por buenos. Si esto sucede, ¡podemos pasar por alto un fallo real sin notarlo! Otro punto es el analizar si una aproximación probabilística es útil en estos casos. Si los resultados de la prueba se encuentran acotados dentro de un margen de tolerancia, es posible eliminar la incertidumbre hasta un grado aceptable para nuestros propósitos.
    </p>
  </div>
  
  <div>
    <h3>
      Mantenibilidad
    </h3>
    
    <p>
      Una prueba fácil de mantener es aquella que no &#8220;se rompe&#8221; fácilmente cuando se les da mantenimiento. Un bajo acoplamiento es probablemente el factor más importante para la facilidad de mantenimiento. El uso de <em>Métodos de fábrica</em> nos permite desacoplar nuestras pruebas de los constructores de clase, que tienden sufrir cambios en sus listas de parámetros más a menudo que otros métodos.
    </p>
    
    <p>
      Dar nombres significativos a nuestras pruebas también es importante para el mantenimiento, así como la legibilidad. Cuando se puede deducir a partir del nombre lo que la prueba está tratando de comprobar, se puede ver si en realidad el código hace lo que se dice que está haciendo. Puede asegurarse que las pruebas mantienen su comportamiento, incluso cuando hay cambios en el API que utiliza.
    </p>
    
    <p>
      Cuando las pruebas se pueden leer, entonces se vuelven más fáciles de mantener. Cuando las pruebas se pueden mantener, entonces es probable que en de hecho, se les dé mantenimiento. Cuando se sabe que las pruebas se mantienen, y se puede inferir lo que están comprobando, entonces es posible confiar en ellas como en la red de seguridad que se supone que son.
    </p>
  </div>
  
  <div>
    <h2>
      Rapidez
    </h2>
    
    <p>
      Una prueba unitaria efectiva debería ejecutarse en milisegundos, <strong>no en segundos</strong>. Si a una prueba tarda más que algunos cientos de milisegundos en ejecutar, es probable que debamos considerarla demasiado lenta. Como en todo, hay excepciones, pero esta es una buena regla a seguir. A continuación explico porqué.
    </p>
    
    <p>
      Una suite de pruebas puede llegar a contener decenas o incluso cientos de pruebas, organizadas en clases, cada una enfocándose a un aspecto particular del código. Si una prueba se ejecuta en un segundo (1000 milisegundos) y tenemos cien de ellas, tendremos que esperar más de dos minutos para conocer el resultado de las mismas. Correr la suite se convierte en si mismo en una interrupción que altera nuestro ritmo de trabajo: La mente se distrae y para cuando finalmente tenemos los resultados, debemos de &#8220;vaciar la pila&#8221; nuevamente y reingresar el contexto que teníamos unos segundos antes de ejecutar la suite.
    </p>
    
    <p>
      Si hacemos esto una y otra vez en el transcurso del día (a la mayoría de los desarrolladores se les complica mantener su atención por más de algunos segundos antes de perder el interés), entonces comenzaremos a evitar el correr nuestras pruebas, lo cual deberíamos hacer cada vez que cambiamos &#8220;algo&#8221; en el código. Y si esto es así, entonces perdemos la confianza en nuestros cambios y en nosotros mismos. Regresamos al ritmo &#8220;tradicional&#8221; y finalmente puede llegar a parecernos &#8220;más fácil&#8221; abrir el depurador de nuestro IDE que dar un par de pasos hacia atrás hasta el punto en que todo aun funcionaba bien.
    </p>
    
    <p>
      Todo ello sin considerar el tiempo perdido. No solo el tiempo de ejecución de las pruebas mismas, sino el tiempo que nos toma volver a entrar en el contexto mental que teníamos justo antes.
    </p>
    
    <p>
      Una sesión de <acronym title="Test Driven Development">TDD</acronym> en realidad debería transcurrir como los ejemplos interactivos al principio de este post. Escribimos algo de código y deberíamos obtener retroalimentación casi inmediatamente. Cada vez que corremos la suite &#8220;en verde&#8221;, aumenta nuestra confianza, en nuestro código, en nuestra suite y en nosotros mismos, lo cual nos mantiene altamente motivados para seguir adelante.
    </p>
    
    <p>
      Volver al ciclo tradicional de modificar/compilar/debuguear destruye esa motivación. Si probar un cambio de una sola linea nos lleva 5 minutos de en el depurador, nuestra motivación se va a los suelos y se convierte en una excusa para alargar los tiempos de desarrollo casi infinitamente.
    </p>
    
    <p>
      Un componente fundamental en la construcción de una suite de pruebas es la habilidad de construirla a partir de subconjuntos más pequeños y enfocados. Es importante ser capaz de probar el sistema completo oprimiendo solo un botón (o con un solo comando en la shell del sistema), pero igualmente importante es poder ejecutar únicamente las pruebas para la clase o el sub-sistema que estamos probando en este momento. La mayoría de los frameworks de la familia XUnit tienen esta capacidad. Se pueden crear suites pequeñas y estas a su vez, incluirlas en suites mayores.
    </p>
  </div>
</div>

<div>
  <h2>
    Cookbook
  </h2>
  
  <div>
    <h3>
      Aprender
    </h3>
    
    <ul>
      <li>
        Escribe muchas pruebas (tantas como puedas). Familiarizate con el ritmo y las reglas de <acronym title="Test Driven Development">TDD</acronym>. Comienza con algo sencillo (¡pero no te detengas ahí!)
      </li>
      <li>
        Cuando encuentres algo que no sabes como probar, apóyate en un compañero. Si no programas en parejas, consulta con un colega. Recolecta ideas de diversas fuentes.
      </li>
      <li>
        Sé persistente y no te rindas. Si quieres obtener los frutos, debes primero poner el trabajo duro.
      </li>
      <li>
        Nunca dejes de aprender. Lee libros (una lista al final de este post), blogs, revistas, etc. Los proyectos de <em>Código Abierto</em> son una excelente fuente de aprendizaje.
      </li>
      <li>
        Conforme escribas más y más pruebas, comienza a organizarlas en suites y asegúrate que estas puedan ejecutarse de forma individual o colectiva, según sea necesario. ¡La organización también es una habilidad que hay que aprender!
      </li>
    </ul>
  </div>
  
  <div>
    <h3>
      Prácticas para el día a día
    </h3>
    
    <ul>
      <li>
        Es recomendable probar una unidad de código solo a través de su API pública (y en términos prácticos, &#8220;protegido&#8221; es efectivamente público). Al hacer esto, obtenemos un mejor aislamiento de los detalles específicos de la implementación.
      </li>
      <li>
        Evita a toda cosa colocar lógica en el código de prueba (<tt>if</tt>-<tt>then</tt>, <tt>switch</tt>/<tt>case</tt>, etc). Donde hay lógica, hay la probabilidad de introducir <em>bugs</em>, ¡y definitivamente no queremos <em>bugs</em> en nuestras pruebas!
      </li>
      <li>
        Evita los <em>&#8220;números mágicos&#8221;</em>. Esto te permitirá entender porqué en una prueba particular un método regresa un valor dado o porque se pasa un cierto valor como parámetro y no otro diferente.
      </li>
      <li>
        Evita calcular el valor esperado, ya que podríamos terminar duplicando el código del producción, incluyendo cualquier error que este pudiera tener. Preferiblemente, calcula el resultado esperado manualmente (y revisalo por lo menos un par de veces) y colócalo como una constante.
      </li>
      <li>
        Evita compartir estado entre pruebas. Debe ser posible ejecutar las pruebas en cualquier orden o incluso, ejecutar una prueba dentro de otra prueba. Mantener las pruebas aisladas de las demás también es un factor indispensable para la confiabilidad y mantenibilidad de las mismas.
      </li>
      <li>
        Sin importar como lo veas, ninguna cantidad de comentarios puede sustituir un código claro. Si una prueba se convierte en un desastre, reescríbela.
      </li>
      <li>
        Si no es posible determinar lo que una prueba está haciendo, es probable que en realidad esté verificando múltiples cosas: hazla pedazos y convierte cada uno en su propia prueba individual.
      </li>
      <li>
        Frecuentemente los errores en el código de pruebas se esconden en los métodos de inicialización. Mantener este código simple y compacto puede ser un gran paso para la mantenibilidad del código.
      </li>
      <li>
        Una unidad de código puede necesitar operar en circunstancias escenarios variables. Esto puede llevar a que el código de inicialización se convierta rápidamente en un desastre. Crea <tt>fixtures</tt> o incluso casos de prueba especializados para cada escenario.
      </li>
      <li>
        Nunca escatimes en claridad. Si es necesario, convierte cada escenario en una clase de prueba individual.
      </li>
      <li>
        Si al probar una parte de tu código parece que requieres tener la mitad o más del sistema presente, verifica el alcance de la misma. ¿Estás probando una sola cosa?
      </li>
      <li>
        Si una parte del código es particularmente resistente a tus esfuerzos de probarla, voltea al código en busca de problemas en el diseño del mismo. Un código fácil de probar frecuentemente está débilmente acoplado con el resto del sistema, es altamente cohesivo y sigue los principios fundamentales del diseño de software.
      </li>
    </ul>
  </div>
  
  <p>
    Espero como siempre que haya sido de utilidad.
  </p>
</div>


 [1]: http://xprogramming.com/