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

    <link href="/assets/swatches/amelia/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>

This assumes you have an 'assets' directory within the root of your directory holding your swatches:

    assets/js/bootstrap.min.js  
    assets/swatches/amelia/bootstrap.min.css  
    assets/swatches/cerulean/bootstrap.min.css
    assets/swatches/cosmo/bootstrap.min.css


Download [Simpli-Swatchable2 swatches](https://github.com/simpliwp/simpli-swatchable2/archive/Bootswatches2.3.2-Namespaced.zip) here. The default namespace is 'bootstrap'. 



When you wish to apply the bootstrap classes, you need to surround your markup with a `.bootstrap` class: 


        <div class="bootstrap">
        bootstrap markup here
        </div>


If you have problems with the markup being applied, add a 'bootstrap' class to the `<html> tag of your site. If you do not want to use namespaces, rebuild the swatches after removing the namespace in the `swatchmaker.less` and `swatchmaker-response.less` files. See the section discussing the `swatchmaker/swatchmaker.less` file for more information.

###Swatch Building Requirements

To compile swatches from less files to css files, you'll need to install node.js and a less compiler.

1. install node.js from here [http://nodejs.org/download/]() 

2. install the less compiler and the compressor plugin: 

        npm install -g less
        npm install -g less-plugin-clean-css


##Creating New Swatches

Creating Swatches from existing Bootswatches involves:

1. Update the Bootswatch Swatches Directory
2. Update Bootstrap
3. Build the Swatches

###Update the Bootswatch Swatches Directory
1. Download the latest [Bootswatch swatches for Bootstrap 2.0]([https://github.com/thomaspark/bootswatch/archive/gh-pages.zip](https://github.com/thomaspark/bootswatch/archive/gh-pages.zip))
2. unzip, and copy the entire contents of the `'2'` directory to the `swatches` directory.
4. Edit the `make-bootswatches.sh` script to include all swatch directory names

        swatches=( amelia cerulean cosmo cyborg default flatly journal readable simplex slate spacelab spruce superhero united )

###Update Bootstrap
Bootstrap can only be updated to the maximum available version of 2+ (Swatchable2 does not support updating to Bootstrap 3.0)  

4. [Download](https://github.com/twbs/bootstrap/releases) the same version of bootstrap that matches the swatches
5. Extract and Rename its bootstrap directory to just 'bootstrap' and replace the existing swatchmaker/bootstrap directory with it.
6. 'make' bootstrap by opening a command line , changing to the `swatchmaker/bootstrap` directory and running `make`

###Build the Swatches
8.  **create the swatches**  

    Open a command line and changing to the swatchmaker directory and running `make swatches`
    
            cd swatchmaker
            make swatches 
    
    or 
        
            ./make-bootswatches.sh

9. **Fix @import url statements** 

    You cannot add a namespace in front of an @import url statement , and as a result, many of the swatches won't include their fonts if you don't take an additional step:

    1. do a search for all @import url statements within the `bootswatch.less` files in the swatches directory. For each file, cut the `@import url` statement from the file, and paste it within the cssimports.less file in the same directory. If no `cssimports.less` file exists, run `make swatches` once - it will add an empty `cssimports.less` file the first time it is run.




###Creating Custom Swatches
Create a custom swatch by duplicating one of the existing swatches and modify the .less files as needed. Then follow the steps to Build the Swatches.






##Troubleshooting

###Correct Fonts Not Used

This may be the result of @import statements being placed within your bootstrap namespace. Swatchable2 makes no effort to prevent this from happening, and it *will* happen if an @import statement is within a less file that you are compiling. The result will look like this, which will break the css import, preventing your fonts from working:

    .bootstrap {
    @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
    }

**To fix the font imports:**

Do a search for eacg '@import url' statement in your less files. Move each statement to the cssimports.less file, and rebuild the swatch.

For a quick fix without rebuilding the swatch, move the @import url statement to the very beginning of your css file and do not include the namespace.

instead of this :

    .bootstrap {
    @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
    }

it should look like this:

    @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');

###Background colors or background images not applied

When you use a stylesheet that is namespaced, the styles within it aren't applied unless the corresponding markup is within a div that contains the namespace id or class.

Because the `<body>` tag surrounds all content, a `<div>` cannot be used, so unless you take the following steps, any styles that apply to the `<body>` tag are ignored.


This is intended behavior for namespaced stylesheetgs, because it lets you inherit the styles from the other body styles from other stylesheets on your site without conflict. If you do not like the behvior, there are 2 ways you can fix it:


1. Fix 1: add the namespace class to the html tag: 


        <html lang="en" class="bootstrap:>

2. Fix 2: Remove the bootstrap namespace class from the stylesheet: 

    change this : 
    
        .bootstrap body {
          background-color: #0f8790;
          background-image: -webkit-gradient(radial, center center, 0, center center, 460, from(#12a5b0), to(#0f8790));
          background-image: -webkit-radial-gradient(circle, #12a5b0, #0f8790);
          background-image: -moz-radial-gradient(circle, #12a5b0, #0f8790);
          background-image: -o-radial-gradient(circle, #12a5b0, #0f8790);
          background-repeat: no-repeat;
        }

    to this : 
    
    
        body {
          background-color: #0f8790;
          background-image: -webkit-gradient(radial, center center, 0, center center, 460, from(#12a5b0), to(#0f8790));
          background-image: -webkit-radial-gradient(circle, #12a5b0, #0f8790);
          background-image: -moz-radial-gradient(circle, #12a5b0, #0f8790);
          background-image: -o-radial-gradient(circle, #12a5b0, #0f8790);
          background-repeat: no-repeat;
        }








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
*  **swatches/\<swatch-name>/variables/less** – Edit this file to customize any of the colors or other variables that you want to change from bootstrap's default.
(This file is identical to bootstrap/variables.less but is here so you dont have to edit the downloaded source)
*  **swatches/lt;swatch-name>/bootswatch.less** – is basically an override file. You can define classes and mixins here and they will override the main bootstrap.less file





##Bootstrap 3.0

Bootstrap 3.0 themes created from the Bootstrap project use grunt to build themes, so is incompatible with this project.

For more information on building Bootstrap 3.0 themes, see [http://bootswatch.com/help/](http://bootswatch.com/help/)



##Downcast Rebuilds

Simpli-Swatchable2 can create config.json files for swatches, which can then be used as downcast skins.

To use this feature, edit make-bootswatch.sh and set DOWNCAST=true:
 
    DOWNCAST=true;

Now when you run `make swatches` , you'll see a config.json file within each of the swatches that are pathed correctly for inclusion into downcast. You'll also see a file `downcast-skins.config` that includes statements that you can copy and paste into downcast's site's config.json file under the `skins` section.



##Repo Maintenance

###Updating swatches:   

1. commit any outstanding changes in the master branch
2. create a new branch ,e.g.: `Boostrap-Swatches-2.3.2`
3. switch to the new branch
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
