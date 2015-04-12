# Artesanos de Software

Este es el código fuente del sitio de Artesanos de Software. Antes usábamos Wordpress pero se convirtió en un problema cuando recibimos muchos ataques y mantener un CMS fue un problema que no queríamos tener.

Ahora el sitio de construye con [Hugo][1] que realmente necesita archivos [Markdown][3] y la definición de una plantilla para generar un sitio estático.

También empezamos a usar Disqus para los comentarios.

Si deseas participar, has fork, agrega tu entrada y manda un Pull Request.


## Como correr el sitio en tu computadora

1. Descarga los fuentes del proyecto
2. Instala [Hugo][1]
3. En la raiz del proyecto en una terminal ejecuta:

    ```bash
    rm -rf public && hugo server --watch --verbose 
    ```
    
    Tambien puedes ejecutar el siguiente shell script:
    
    ```bash
    ./run.sh
    ```
4. Navega [aquí][2]
5. ¡Disfruta!


 [1]: http://gohugo.io
 [2]: http://localhost:1313/software
 [3]: http://daringfireball.net/projects/markdown/