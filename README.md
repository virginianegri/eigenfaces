# Eigenfaces

Face recognition with GUI using eigenfaces

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Background

This face recognition system is built using the eigenfaces techniques explained in [Robust Face Recognition for Data Mining](https://espace.library.uq.edu.au/data/UQ_18/Robust_Face_Recognition_for_Data_Mining.pdf?Expires=1560827531&Signature=QZGw30GlA40G-LjRVbPlcXCGj6UwlTdoNVHT8h6wAFoARExNywyM4BaQh0C-I0l8XVgEdYDbOqGYNuBwuYjNvUlXhoYD-Jnt2y4PbGOzzHZtWZot5cUgyJgUihMZHLur8T-fKEgE-mdAHAiPCgKumro0utCfjmEA~1-rXFqUDr8gNPB3Phui8M-AQfK287wTjWXq2a-T-m~qopWEjvh2cVoz147rDLzeMJv1A87X-HDLdKfDjjm00pr1DHSCkMHhdsOfbT77Dl8V0M-6IC-jVKoiKJm5pYlzLSTzCxjhVuWCS2roY2rc0Lhbmh8tRSFZQXy0UXYBM0lvw7a3M8ALaQ__&Key-Pair-Id=APKAJKNBJ4MJBJNC6NLQ) by Lovell et al.

Eigenfaces uses Principal Component Analysis on grayscale images.

### Installing

Download or clone the repository.

Open the eigenfaces directory in MATLAB and run the imageSelector.m script in the command window.

```
run imageSelector.m
```

This will load the GUI for face recognition.

Select a probe image in the listbox.

The selected image will be shown in the panel below, while the matching gallery face will be shown on the panel on the right together with the class label.


## Built With

* [Matlab CV Toolbox](https://au.mathworks.com/products/computer-vision.html) - The Matlab framework used

### Customize

New gallery faces can be added into the eig folder if in bitmap format, grayscale and in the same conditions as existing faces.
Probe images corresponding to the newly added faces in the gallery can be added in separate folders.

## Authors

* **Virginia Negri** 



