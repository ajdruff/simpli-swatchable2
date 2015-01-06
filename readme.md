#About Simpli-Swatchable2
Allows you to customize a build of bootstrap 2+ to output a customized version of bootstrap.css that enables you to easily add a namespace or make other changes. A fork of [bootswatch](https://github.com/thomaspark/bootswatch/).



##Why Use Simpli-Swatchable2 ?

Simpli-Swatchable2 gives you two advantages:

1. **Prevents Bootstrap styling from being corrupted by conflicting stylesheets**.   
    
    It does this by requiring you to apply a class to the element in which you place your Bootstrap 2.0 markup. 

2. **Allows you to easily do a bulk rebuild of the Bootswatch swatches**

    Run one command `make swatches` and rebuild all the swatches with a new namespace or whatever other edits you made in their less files.




####Quickstart - Using the Namspaced Bootstrap 2.0 Swatches
Simpli-Swatchable2 swatches can be used without any further modification. Simply download the swatches, and add them like you would any Twitter Bootstrap 2.0 css and javascript file.

Download [Simpli-Swatchable2 swatches](https://github.com/simpliwp/simpli-swatchable2/archive/Bootswatches2.3.2-Namespaced.zip) here. The default namespace is 'bootstrap'. 



When you wish to apply the bootstrap classes, you need to surround your markup with a `.bootstrap` class: 


        <div class="bootstrap">
        bootstrap markup here
        </div>



###Swatch Building Requirements

To compile swatches from less files to css files, you'll need to install node.js and a less compiler.

1. install node.js from here [http://nodejs.org/download/]() 

2. install the less compiler and the compressor plugin: 

        npm install -g less
        npm install -g less-plugin-clean-css




###Updating Bootswatch Swatches
1. Download the latest version of swatches from here: [https://github.com/thomaspark/bootswatch/archive/gh-pages.zip](https://github.com/thomaspark/bootswatch/archive/gh-pages.zip)
2. unzip, and copy the entire contents of the `'2'` directory to the `swatches` directory.
3. to create a custom swatch, duplicate one of the existing swatches and use it as a starting point
4. Edit the make-bootswatches.sh script to include all swatches

Edit the following line in `make-bootswatches.sh` to add the swatches you want to build

    swatches=( amelia cerulean cosmo cyborg default flatly journal readable simplex slate spacelab spruce superhero united )



###Updating Bootstrap 2+ (does not support updating to Bootstrap 3.0)
4. Download the version of bootstrap that matches the swatches from here : [https://github.com/twbs/bootstrap/releases](https://github.com/twbs/bootstrap/releases)
5. rename its bootstrap directory to just 'bootstrap' and replace the existing swatchmaker/bootstrap directory
6. 'make' bootstrap by opening a command line , changing to the swatchmaker/bootstrap directory and running `make`
8.  create the swatches  by opening a command line and changing to the swatchmaker directory and running `make swatches`

        cd swatchmaker
        make swatches 

    or 
    
        ./make-bootswatches.sh


###cssimports.less
Since @import statements do not work with namespaces, add any @import statements in this file for things like fonts,etc.

e.g.: 

    @import url(http://fonts.googleapis.com/css?family=Rock+Salt);
    @import url(http://fonts.googleapis.com/css?family=Tangerine);
    @import url(http://fonts.googleapis.com/css?family=Schoolbell);
    @import url(http://fonts.googleapis.com/css?family=Permanent+Marker);



`cssimports.less` file does not exist in a newly downloaded batch of bootswatch swatches. An empty cssimports.less file will be created the first time `make swatches` is run. You can then edit it and run `make swatches` a final time to create the final css files.

###bootstrap-customize.less

If you only need a subset of bootstrap classes, duplicate bootstrap.less , customize it to your needs, and use it instead: 

1. create a copy of bootstrap.less

        cp bootstrap/less/bootstrap.less bootstrap/less/bootstrap-customize.less

2. edit `bootstrap-customize.less` to include only the classes you need
3. edit the `swatchmaker.less` file to replace references to `bootstrap.less` with `bootstrap-customize.less`

        .bootstrap {
        //@import "../../bootstrap/less/bootstrap.less";  //comment this line out
        @import "../../bootstrap/less/bootstrap-customize.less"; //add this line
        @import "variables.less";
        @import "bootswatch.less";
        @import "../../bootstrap/less/utilities.less";
        }

> Note that either bootstrap/less/bootstrap-customize or bootstrap/less/bootstrap.less must be commented out. You can't use both at the same time.

4. compile the swatches
        
        make swatches


##Other Bootswatch Files

Below is a brief guide of the important files in bootswatch that allows you to modify the output.



   * **swatchmaker/swatchmaker.less** – this is the main less file used by the `make swatches` script to compile each swatch. When `make swatches` is run, `swatchmaker.less` will be copied into each swatch directory, and then compiled. You shouldn't have to edit anything here except possibly customize the namespace.

    the file will look something like this:

        .bootstrap {
        @import "../../bootstrap/less/bootstrap.less";
        @import "variables.less";
        @import "bootswatch.less";
        @import "../../bootstrap/less/utilities.less";
        }
 

    The string '.bootstrap' is the namespace. If you don't want a namespace at all, delete it, including the starting dot. If you just want to rename it, you can rename it to another class namespace like `.mycustomnamespace` or even an id namespace like `#mycustomnamespace` . 

    A namespace allows you to largely prevent the impact of other stylesheets from impacting bootstrap or for bootstrap to impact other styling. In practice, you'd have to enclose your bootstrap styled markup with a <div class="namespace"></div>

        <div class="bootstrap">
        bootstrap markup here
        </div>

     if you customized it to use an id as a namespace, e.g.: `#bootstrap`, the id could only appear once on the page and would look like this :

        <div id="bootstrap">
        bootstrap markup here
        </div>

*  **swatchmaker/swatchmaker-responsive.less** – responsive version of swatchmaker.less. If you changed the namespace in swatchmaker.less, change it here also.
*  **swatches/swatch-name/variables/less** – Edit this file to customize any of the colors or other variables that you want to change from bootstrap's default.
(This file is identical to bootstrap/variables.less but is here so you dont have to edit the downloaded source)
*  **swatches/swatch-name/bootswatch.less** – is basically an override file. You can define classes and mixins here and they will override the main bootstrap.less file





##Bootstrap 3.0

Bootstrap 3.0 themes created from the Bootstrap project use grunt to build themes, so is incompatible with this project.

For more information on building Bootstrap 3.0 themes, see [http://bootswatch.com/help/](http://bootswatch.com/help/)


##Repo Maintenance

To update swatches:   

1. create a new branch ,e.g.: `Boostrap-Swatches-2.3.2`
2. rebuild the swatches
3. delete everything in the branch except the `swatches-compiled` directory
4. commit the branch
5. switch to master
5. create a tag of the branch
6. delete the branch
7. push to remote
8. update the readme with the new link


###Problems Compiling

---

**NameError with Bootstrap2.3.2**
**error:**

    NameError: #grid > .core > .span is undefined in C:\wamp\www\wpdev.com\public_html\wp-content\plugins\simpliwp-downcast\skins\bootstrap-maker\bootswatch-2.2.2-1\swatchmaker\bootstrap\less\navbar.less  
    on line 199, column 3:  
    198 .navbar-fixed-bottom .container {  
    199   #grid > .core > .span(@gridColumns);  
    200 }

**Solution** [http://stackoverflow.com/a/26628310](http://stackoverflow.com/a/26628310) 

In the less/navbar.less file:
 
Replace:
    
    .navbar-static-top .container,
    .navbar-fixed-top .container,
    .navbar-fixed-bottom .container {
      #grid > .core > .span(@gridColumns);
    }
With:
    
    .navbar-fixed-top .container,
    .navbar-fixed-bottom .container { 
    width: (@gridColumnWidth * @gridColumns) + (@gridGutterWidth * (@gridColumns - 1));
    }  

----
