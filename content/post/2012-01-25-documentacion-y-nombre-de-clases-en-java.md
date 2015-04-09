---
title: Documentación y Nombre de Clases en Java
author: ivan
layout: post
date: 2012-01-25
url: /2012/01/25/documentacion-y-nombre-de-clases-en-java/
categories:
  - Idea
---
Lo que se busca en este artículo es proponer una forma de documentar y a la vez nombrar clases en Java. Al final de este artículo se tiene como objetivo el entender las ventajas y mejoras de documentar clases y a la vez elegir nombres apropiados para las clases apoyandonos en esta sencilla práctica.  
</br>  
Sería bueno empezar por mostrar aquello que se intenta mejorar. Es muy común que al aprender un nuevo patrón de diseño, un framework, o bien al implantar una arquitectura de referencia nuestra primera tendencia sea hacer lo siguiente:  Si estamos aprendiendo Spring Framework:  
</br>

<pre class="brush:java;">public class UsuarioPOJO {
// código de la clase
}</pre>

</br>  
Si se está aprendiendo algún patrón de diseño para que ciertos componentes se expongan como servcios o similares intenciones:  
</br>

<pre class="brush:java;">public class BusquedaUsuariosFacade{
// código de la clase
}</pre>

</br>  
Si se tiene un estilo de diseño de responabilidades y roles, o aplicar un DDD, que indica que necesitamos ciertos colaboradores como:  
</br>

<pre class="brush:java;">public class UsuarioBuilder{
// código de la clase
}</pre>

</br>  
Por el momento, es de esperar que basten estos ejemplos. El punto aquí es que los nombres que se asignan a las clases son algunas veces bastante atados al Framework que se utiliza, a algún patrón de diseño, o bien sólo a un rol o responsabilidad. Todo esto son detalles técnicos y en verdad hacen que el programador se olvide del dominio específico para el que realiza la aplicación. Uno podría aventurarse a decir que este mecanicismo es parte de que pocos sean críticos en cuanto a su diseño y que realmente se aprecie el problema en su escencia. Y en analogía con lo que indica Uncle Bob el código deberían gritar el dominio del problema y no una tecnología específica, es decir, Hibernate, Spring o ese nuevo patrón o tecnicismo que acabamos de aprender o que aplicamos como receta de cocina.  
</br>  
No está de más decir que algunos desarrolladores se olvidan del dominio o contexto del aplicativo que están resolviendo y simplemente le llaman a sus clases: FactoryEntitiyBean, CrudServiceBean, AuditLoggerBean, EventDispatcherBean, LoginStrategyBean, ThreadPoolImpl . Y el dominio del problema se desvanece.  
</br>  
Para efectos de aprendizaje está muy bien nombrar a las classes así, pero para la práctica no. Los ejemplos de diversas fuentes nombran sus clases haciendo clara referencia a las partes del tema que quieren aclarar pero al final pocos dicen que no se debe seguir al pie de la letra los nombres del ejemplo.  
</br>  
Con tales antecedentes presentemos a la propuesta de mejora. En UML muchos de estas palabras que agregamos como sufijo (o prefijo) a las clases son los llamados stereotypes que comunmente aparecen en los diagramas de clases o de secuencia. Y son bastante eficaces en mostrar la responsabilidad o rol que juegan en el diseño de la solución. A nivel de código estos stereotypes se pueden conservar y mantener el código documentado con el uso de una anotación. Que al final servirá como una marca (o tag) bastante útil.  
</br>

<pre class="brush:java;">@Stateless
@Remote(BusquedaUsuarios.class)
@Facade(responsability="Ejemplo de responsabilidad descrita",
documentationLink="http://wiki.artesanos.de/software")
public class BusquedaUsuariosAdscritos implements BusquedaUsuarios { ... } </pre>

</br>  
Tal y como se observa el nombre de nuestra clase ha quedado más limpio y sólo hace referencia al dominio/negocio. Admás se ha logrado mediante el uso de anotaciones a la medida documentar y plasmar ese rol o responsabilidad que anteriormente adjuntabamos a manera de sufijo (o prefijo).  
</br>  
Ahora bien, analicemos que ventajas nos reporta esta práctica. Hemos observado que se utilizan anotaciones y es necesario responder ¿por qué? Las anotaciones tienen algunas ventajas sobre el JavaDoc, ya que este metadata permanece en en el byte code y es accesible via reflection. Este tipo de documentación puede ser inclusive aprovechada durante el proceso de build o con heramientas de análisis estático de código.  
</br>  
La declaración de la anotación tipo marca para identificar un Facade como pieza de la solución, es el siguiente:  
</br>

<pre class="brush:java;">@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Facade {
/**
* Un link a documentación existente,
* o "user story" o "use case".
*/
String documentationLink() default "";
/**
* La intención escencial y responsabilidad(es)
* de la Facade que se implementa
*/
String responsibility();
}</pre>

</br>  
En este ejemplo podemos observar que el atributo &#8220;documentationLink&#8221; es opcional, en el bien podría hacerse referencia a un sitio donde haya información de la decisión de diseño o proporcione la &#8220;user story&#8221; o el &#8220;use case&#8221; asociado a este componente. Para el caso de &#8220;responsability&#8221; por el contrario no es opcional. Algo interesante es que el uso de anotaciones puede forzar al desarrollador a proveer algún tipo de información escencial, lo cual sería el caso para este atributo. Adicionalmente podemos agregar cuantas anotaciones necesitemos para definir roles o responsabilidades de la clase, aunque lo mejor sería condensarlo en una sola anotación que exprese toda la idea.  
</br>  
Supongamos que nuestra clase ha dejado de ser un &#8220;Facade&#8221; protagonista al exterior y ahora simplemente es un &#8220;Provider&#8221; al interior de la implementación. Este cambio sin modificar el nombre de la clase se lograría facilmente colocando su nuevo Rol/Responsabilidad mediante la anotación correspondiente dentro de nuestra arquitectura propuesta. Es muy cierto que el cambio quizá involucre un cambio de paquete o algún otro refactor pero el punto es que la clase con su nombre dentro del dominio del problema sigue intacto, sólo ha rotado en su posición dentro de la estructura sin haberse preconcebido con un prefijo/sufijo a un Rol/Responsabilidad definitivo o por la tecnología en uso.  
</br>

<pre class="brush:java;">@Stateless
@Local(BusquedaUsuarios.class)
@Provider(responsability="Ejemplo de nueva responsabilidad descrita",
documentationLink="http://wiki.artesanos.de/software")
public class BusquedaUsuariosAdscritos implements BusquedaUsuarios { ... } </pre>

</br>  
Este tipo de anotaciones pueden inclusive ser más formalizadas y proveer más información que sea utilizada como meta-data para ser consumida por un Interceptor de los proporcionados por EJB3.x o alguna estrategia similar de AOP. Esta última sería la gran ventaja de adoptar esta propuesta ya que además de fomentar la claridad en los nombres de clases permitirá habilitar o deshabilitar comportamientos en las clases marcadas con anotaciones.

En resumen: Es mejor generar anotaciones propias (derivados de la arquitectura propuesta) que generen documentación útil y adicionen compotamiento en tiempo de ejecución (mediante interceptores, AOP); y con ello dejar los nombres de clases limpios y enfocados al dominio del problema.

<div id="wp_fb_like_button" style="margin:5px 0;float:none;height:100px;">
  <fb:like href="http://artesanos.de/software/2012/01/25/documentacion-y-nombre-de-clases-en-java/" send="false" layout="like" width="450" show_faces="true" font="arial" action="" colorscheme="light"></fb:like>
</div>