---
title: Pasar de la curiosidad al código.
author: rodrigo_salado
layout: post
date: 2011-09-01
url: /2011/09/01/pasar-de-la-curiosidad-al-codigo/
categories:
  - Article
tags:
  - ajax
  - javascript
  - java
  - websocket
  - comet
---

## Pasar de la curiosidad al código.

Para mí, pasar de una curiosidad por un nueva tecnología, a código que pueda usar para jugar un rato o usar en algún proyecto es complicado y requiere de mucho esfuerzo, aun así con el tiempo he pulido un poco este proceso. Quiero compartirles con un ejemplo como es que llego de una curiosidad por _Comet_ a código.

Todo inicia con una simple pregunta, por ejemplo, ¿cómo podría pintar _logs_ de mi aplicación en un _div_ de _HTML_ sin tener que recargar la página? Esta es la parte más difíciles, porque es en donde tengo que hacer preguntas con las palabras correctas, primero a Google y luego a uno que otro _Chapulin Colorado de la programación_ para que me den la respuesta u orientación que deseo. Porque bien me pudo haber dicho cualquier fuente que _Ajax_ me resolvía el problema, y en efecto me lo resuelve pero _Reverse Ajax_ o _Ajax Push._  __Las preguntas adecuadas son la solución__.

Después de mucho investigar qué es lo que necesito aprender, logro saber la palabra clave, el inicio del la aventura, _Comet._ Es momento de empaparme en la filosofía de la tecnología, saber ¿para qué sirve?, si es lo que necesito en realidad, ¿por qué existe?, ¿que existía antes?, etc.

Esta parte abre muchas interrogantes, en este caso supe que no solo se llama _Comet_, también que existen otras formas de resolver el mismo problema, por ejemplo con _WebSocket_.

Bueno pues a escribir mas palabras en el buscador. Momento, que un error en el que cuido no caer, es en abarcar mucho y reducir mi visión en búsqueda de la de la solución. Este problema lo resuelvo viendo demos, leyendo más artículos, y si aun no puedo saber con certeza que tecnología es la adecuada, es momento de la <em>resignación</em>, no hay de otra más que empezar a ensuciarse los dedos y quemarse las pestañas, pero sin perder el enfoque y sin desesperarse. <em>La paciencia es una aliada</em>.

Me he dado cuenta que mucha de la información que circula es repetitiva, dice muchas veces lo mismo, solo diferentes autores, así que necesito distinguir de las fuentes que valen la pena el esfuerzo, pero esto es algo gradual. Después de leer varios artículos, veo la palabra <em>Bayeux Protocol</em> una y otra vez, también <em>CometD Bayeux Ajax Push</em>, bueno pues resulta que la mejor fuente para aprender una nueva tecnología es en …, pues en la fuente misa de la tecnología, en la página oficial y su documentación. <em>Soy capaz de leer 5 hojas con contenido técnico en media hora, y también soy capaz de releerlas y entender algo diferente de la última vez en varias ocasiones seguidas.</em> Nadie nos agradecerá ni dara premios por leer rápido y no entender nada de lo que dice la documentación, lamentablemente no siempre existen los ejemplos copy/paste, así que solo queda ponerse cómodo y disfrutar de la función, o del método, en fin.

Al final de de todo esto, leo completamente la página <a href="http://cometd.org/documentation" target="_top"><em>http://cometd.org/documentation</em></a> y resulta que si existe un copy/paste sencillo <em>primer</em>, sigo las instrucciones a la <em>Maven Way</em> y guala, ya soy un experto en esta tecnología.

Pues no, resulta que no hice mi tarea y no tendré recreo, así que a revisar el código. Después de descargar el proyecto <em>mvn</em>, reviso y estudio el código, gano la confianza para hacer cambios al código y ver qué sucede. Este momento es muy importante porque es cuando adaptamos el código que nos dan de ejemplo a nuestras necesidades.

Modifico el archivo `application.js` para <em>adaptarlo al estilo en el que yo escribo código</em> y con esto estudio y entiendo más sobre <em>comet</em>, por ejemplo:


```js
var cometd = $.cometd;

$(document).ready(function(){

    var _connected = false;
    function _metaConnect(message){
        if (cometd.isDisconnected()){
            _connected = false;
            _connectionClosed();
            return;
        }

        var wasConnected = _connected;
        _connected = message.successful === true;
        if (!wasConnected && _connected){
            _connectionEstablished();
        }
        else if (wasConnected && !_connected){
            _connectionBroken();
        }
    }
    // Function invoked when first contacting the server and
    // when the server has lost the state of this client
    function _metaHandshake(handshake){
        if (handshake.successful === true){
            cometd.batch(function(){
                cometd.subscribe('/hello', function(message){
                    $('#body').append(
                        '<div>Server Says: ' + 
                        message.data.greeting + '</div>');
                });
                // Publish on a service channel since the 
                // message is for the server only
                cometd.publish('/service/hello', { name: 'World' });
            });
        }
    }

    var cometURL = location.protocol + "//" + 
                   location.host + config.contextPath + "/cometd";
    cometd.configure({
        url: cometURL,
        logLevel: 'debug'
    });

    cometd.addListener('/meta/handshake', _metaHandshake);
    cometd.addListener('/meta/connect', _metaConnect);
    cometd.handshake();
});

// Disconnect when the page unloads
$(window).unload(function(){
    cometd.disconnect(true);
});

/*Funciones xyz*/
var  _connectionEstablished = function(){
    $('#body').append('<div>CometD Connection Established</div>');
}

var _connectionBroken = function(){
    $('#body').append('<div>CometD Connection Broken</div>');
}

var _connectionClosed = function (){
    $('#body').append('<div>CometD Connection Closed</div>');
}

```

Y para terminar modifico `HelloService.java` con una muy ligera modificación, quedando así:

```java
public void processHello(ServerSession remote, Message message) throws InterruptedException{
  Map input = message.getDataAsMap();
  String name = (String)input.get("name");

  Map output = new HashMap();
  output.put("greeting", "Hello, " + name);
  remote.deliver(getServerSession(), "/hello", output, null);

  Thread.sleep(3000);

  output.put("greeting", "Hello, " + "artesanos.de/software");
  remote.deliver(getServerSession(), "/hello", output, null);
}
```

```bash
Salida:
Server Says: Hello, World
CometD Connection Established
CometD Connection Broken
CometD Connection Established
Server Says: Hello, artesanos.de/software
```
    
Gracias por tu tiempo y saludos. Atentamente:

Rodrigo Salado Anaya
    