# Download
Batch download the [BigBrain](https://bigbrain.loris.ca/main.php) slices and convert them into jpeg at:
- 100% quality 100% size. In subfolders `jpeg_100`
- 80% quality 100% size. In subfolders `jpeg_80`
- 80% quality 10% size. In subfolders `jpeg_thumb`
- original png In subfolders `png`

Notice: you need to have [Imagemagick](https://www.imagemagick.org/script/download.php) installed to convert and resize images.

In addition, you can modify the first 3 lines of the script to change:
- the index of the first slice to be downloaded: `firstIndex`
- the index of the last slice to be downloaded (including this one): `lastIndex`
- the section, can be "Coronal", "Axial" or "Sagittal" - mind the capital! `section`

The slices will go into a subfolder named upon the direction (e.g. 'Coronal').

Then, launch the script:
```bash
$ ./download.sh
```

Here are the interval of slices for each section:
- Coronal: 1 to 7404
- Axial: 1 to 5711
- Sagittal: 1 to 6572

Notice: the BigBrain was captured in its coronal section, the sagittal and axial sections where reconstructed based on the coronal.

**Tip**  
If you don't care about having slices that are smaller (in MB or in size) and you are ok with having only the png, you can comment out the lines of the script that start by `convertImage`. Then, getting all the slices will be much faster!

# Reset
If you want to remove all the images you have downloaded and converted so far, you
can also use the `reset.sh` script:

```bash
$ ./reset.sh
```
Notice: the script asks for confirmation first!
