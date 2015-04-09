---
title: Un poco de refactor…
author: neodevelop
layout: post
date: 2011-08-18
url: /2011/08/18/un-poco-de-refactor/
categories:
  - Sin categoría
---
¿Qué significa hacer un refactor?, en pocas palabras lo puedo definir como saldar la deuda técnica que lleguemos a tener en un proyecto y la oportunidad de mejorar nuestro código&#8230;

A veces podemos aprovechar las características de un framework o lenguaje para hacer refactor es una buena opción para mejorar nuestro código y saldar dicha deuda, además seguimos una pequeña filosofía que dice: &#8220;Deja el código mejor de como lo encontraste&#8230;&#8221;

Bien, hace poco tuve el chance de cooperar con un proyecto y encontré esto en el código de un controller:

<pre class="brush:groovy;">class SpringSocialTwitterController{
  
  // Properties ...
  
  def index = {
    if (isConnected()) {
      // Siempre mostramos el 'profile' en el index
      def model = ["profile": getTwitterApi().userOperations().getUserProfile()]
      //...
    } else {
      render(view: SpringSocialTwitterUtils.config.twitter.page.connect)
    }
  }

  def timeline = {
    if (isConnected()) {
      //...
    } else {
      render(view: SpringSocialTwitterUtils.config.twitter.page.connect)
    }
  }

  def profiles = {
    if (isConnected()) {
      //...
    } else {
      render(view: SpringSocialTwitterUtils.config.twitter.page.connect)
    }
  }

  // ... más acciones similares

  Boolean isConnected() {
    connectionRepository.findPrimaryConnection(Twitter.class)
  }
}
</pre>

El primer acercamiento esta muy bien, de hecho funcionaba perfecto, pero decidí hacer un poco de refactor sobre el controller con las características que me provee el framework usando un poco de interceptores&#8230;

Mi primer acercamiento fue:

<pre class="brush:groovy;">def beforeInterceptor = {
  if(!connectionRepository.findPrimaryConnection(Twitter.class)){
    // Necesito autenticarme
    render(view: SpringSocialTwitterUtils.config.twitter.page.connect)
    // no ejecutamos el request
    return false
  }else{
    return true
  }
}
</pre>

Funcionó, aunque la sensación de dejar el método original isConnected() no me causaba mucha satisfacción, por eso decidí seguir usándolo, por lo que cree una nueva acción para autenticar y con un poco de las bondades del lenguaje hice referencia a ella en el interceptor&#8230;

<pre class="brush:groovy;">def beforeInterceptor = [action:this.&#038;auth]

// Acciones...

def auth(){
  if(!isConnected()){
    render(view: SpringSocialTwitterUtils.config.twitter.page.connect)
    return false
  }
}
</pre>

Sin embargo tenía un problema, esta misma acción podía quedar en un loop infinito si la mandaba a llamar a si misma y además para el index siempre iba a necesitar el objeto profile&#8230;

<pre class="brush:groovy;">def beforeInterceptor = [action:this.&#038;auth,except:'login']

// Más Acciones...

def login = {
  def model = ["profile": getTwitterApi().userOperations().getUserProfile()]
  render(view: SpringSocialTwitterUtils.config.twitter.page.connect)
}

def auth(){
  if(!isConnected()){
    redirect(action:'login')
    return false
  }
}
</pre>

Y listo, con esto así sólo era cuestión de quitar los if&#8217;s y tomar la lógica invertida del interceptor para que al final quedara así:

<pre class="brush:groovy;">class SpringSocialTwitterController{

  // Properties ...

  def beforeInterceptor = [action:this.&#038;auth,except:'login']

  def index = {
    //...Look ma, no if
  }

  def timeline = {
    //...Look ma, no if
  }

  def profiles = {
    //...Look ma, no if
  }

  // ... más acciones similares

  Boolean isConnected() {
    connectionRepository.findPrimaryConnection(Twitter.class)
  }

  def login = {
    def model = ["profile": getTwitterApi().userOperations().getUserProfile()]
    render(view: SpringSocialTwitterUtils.config.twitter.page.connect, model: model)
  }

  def auth(){
    if(!isConnected()){
      redirect(action:'login')
      return false
    }
  }
  
}
</pre>

Un refactor que no interrumpe la funcionalidad que existía&#8230;

<div id="wp_fb_like_button" style="margin:5px 0;float:none;height:100px;">
  <fb:like href="http://artesanos.de/software/2011/08/18/un-poco-de-refactor/" send="false" layout="like" width="450" show_faces="true" font="arial" action="" colorscheme="light"></fb:like>
</div>