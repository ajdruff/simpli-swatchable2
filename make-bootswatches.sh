#! /bin/bash

##########
# Rebuilds Swatches using swatchmaker.less
#
#

swatches=( amelia cerulean cosmo cyborg default flatly journal readable simplex slate spacelab spruce superhero united )

OUTPUT=swatches-compiled
INPUT=swatches
DOWNCAST=false;  ## default: false; true to add a configuration file for use by the Downcast framework
DOWNCAST_FILE=downcast-skins.config  ## provides a listing of skins

SWATCH_COUNT=0;
##remove downcast configuration if it exists




for swatch in "${swatches[@]}"
do

SWATCH_COUNT=$(($SWATCH_COUNT + 1))  #count so we can track whether to create a new downcast-config.json file
## copy the swatchmaker.less files into each of our INPUT directories
cp swatchmaker.less "${INPUT}"/"${swatch}"/swatchmaker.less
cp swatchmaker-responsive.less "${INPUT}"/"${swatch}"/swatchmaker-responsive.less

## Create dummmy missing files . Add these if the swatch source directory doesnt have them
## so the @import statements dont choke and prevent compile
MISSING_SWATCH_FILES=( cssimports.less bootswatch.less )
for MISSING_SWATCH_FILE in "${MISSING_SWATCH_FILES[@]}"
do

if [ ! -f "${INPUT}"/"${swatch}"/"${MISSING_SWATCH_FILE}" ]; then
touch "${INPUT}"/"${swatch}"/"${MISSING_SWATCH_FILE}"
fi
done


## compile the css into output directories

lessc "${INPUT}"/"${swatch}"/swatchmaker.less "${OUTPUT}"/"${swatch}"/bootstrap.css
lessc "${INPUT}"/"${swatch}"/swatchmaker.less "${OUTPUT}"/"${swatch}"/bootstrap.min.css --clean-css
lessc "${INPUT}"/"${swatch}"/swatchmaker-responsive.less "${OUTPUT}"/"${swatch}"/bootstrap-responsive.css
lessc "${INPUT}"/"${swatch}"/swatchmaker-responsive.less "${OUTPUT}"/"${swatch}"/bootstrap-responsive.min.css --clean-css


## Copy misc swatch files from input to output directories 
SWATCH_FILES=( index.html thumbnail.png )
for SWATCH_FILE in "${SWATCH_FILES[@]}"
do

if [ -f "${INPUT}"/"${swatch}"/"${SWATCH_FILE}" ]; then
cp "${INPUT}"/"${swatch}"/"${SWATCH_FILE}" "${OUTPUT}"/"${swatch}"/"${SWATCH_FILE}"
fi
done


## Add Downcast Configuration

if [ "${DOWNCAST}" == true ]; then
cp downcast-config/config.json "${OUTPUT}"/"${swatch}"/config.json
sed -i  "s/__NAME__/${swatch}/" "${OUTPUT}"/"${swatch}"/config.json



DOWNCAST_PATH=\"/bootstrap/"${swatch}"\"

# Add a configuration statement to the Downcast Configuration File
# if this is the first attempt, we create a new file  by using a single output bracket >
if [ "${SWATCH_COUNT}" -eq 1 ]
then
  echo \""${swatch}"\":$'\n'{\"active\": false, \"path\": "${DOWNCAST_PATH}"},>"${OUTPUT}"/"${DOWNCAST_FILE}"
else
  echo \""${swatch}"\":$'\n'{\"active\": false, \"path\": "${DOWNCAST_PATH}"},>>"${OUTPUT}"/"${DOWNCAST_FILE}"
fi 



fi

# update user with message e.g: "Created swatch swatches-compiled/united"
echo "Created  ""${OUTPUT}"/"${swatch}";
done

## Copy the img directories and the javascript from the main bootstrap directory into output directories
## they are copied into the output directory instead of into subdirectories because they are shared files 
## and the default bootswatch variables.less have them pathed that way
cp -r bootstrap/img "${OUTPUT}"/
mkdir -p "${OUTPUT}"/js
cp  bootstrap/docs/assets/js/bootstrap.js "${OUTPUT}"/js/bootstrap.js
cp  bootstrap/docs/assets/js/bootstrap.min.js "${OUTPUT}"/js/bootstrap.min.js

