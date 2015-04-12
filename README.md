# Artesanos de Software

Este es el código fuente del sitio de [Artesanos de Software][4]. Antes usábamos Wordpress pero se convirtió en un problema cuando recibimos muchos ataques y mantener un CMS fue un problema que no queríamos tener.

Ahora el sitio de construye con [Hugo][1] que realmente necesita archivos [Markdown][3] y la definición de plantillas para generar un sitio estático.

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


## Como crear una nueva entrada
 
 1. Tener instalado [Hugo][1]
 2. En la raiz del proyecto en una terminal ejecuta:
 
 
    ```bash
    hugo new post/el-nombre-de-tu-nueva-entrada.md
    ```
    
    > Es importante que el archivo termine con la extensión **.md**
    
3. El archivo de tu entrada se localizara en:

   ```
   ./content/post/el-nombre-de-tu-nueva-entrada.md
   ```    
   
   Ahora  puedes editarlo usando [Markdown][3]

4. Ejecutar el sitio, revisa la sección anterior. Ya debería estar disponible tu nueva entrada.

## Reglas para crear nuevas entradas

* Las entradas deben crearse dentro del directorio  _./content/post/_
* El nombre del archivo debe seguir la siguiente estructura:

   ```
   {año}-{mes}-{dia}-{nombre}.md
   ```    
   
   Ejemplos:

   ```
   2015-04-11-mi-nueva-entrada.md
   ```   
   
   > el nombre del archivo se sugiere que sea breve, pero que indique claramente sobre que se trata.


 [1]: http://gohugo.io
 [2]: http://localhost:1313/software
 [3]: http://daringfireball.net/projects/markdown/
 [4]: http://artesanos.de/software
 
 
 