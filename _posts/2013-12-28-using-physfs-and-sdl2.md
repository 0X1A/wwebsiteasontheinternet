---
layout: post
title:  "Using PhysFS and SDL2"
date:   2013-12-28 10:03:24
desc: Somewhere out there, in memory
---

This is a basic tutorial on how to implement PhysicsFS and SDL using the 
SDL_RWops structure. (This tutorial assumes that the reader has basic knowledge 
of using SDL)

##The process for this is as follows:

1. Set the archive being open using PhysFS
2. Open the file within the archive
3. Open the asset with SDL
4. Freeing memory

### 1. Setting the archive 
Before opening a file we must first set an archive for PhysFS to open
{% highlight c++ linenos %}
int SetArchive(const std::string Archive) 	    \\Function to set the archive being opened
{
    PHYSFS_mount(Archive.c_str(), NULL, 1); 	\\For details on (arg, NULL, 1) read 
        										\\the PhysFS documentation
    return 0;
}
{% endhighlight %}

### 2. Opening the file
Now that the archive is set a file within it can be opened. This function opens 
a file within the arcive set by `SetArchive`.
{% highlight c++ linenos %}
const char *OpenFile(const std::string O_File)
{
	PHYSFS_openRead(O_File.c_str());
    PHYSFS_file *R_File = PHYSFS_openRead(O_File.c_str());
    PHYSFS_sint64 Size = PHYSFS_fileLength(R_File);
    char *Data = new char[PHYSFS_fileLength(R_File)];
    PHYSFS_read(R_File, Data, 1, Size);
    
    return O_File.c_str();
}
{% endhighlight %}

### 3. Loading using SDL
The file is now on memory and can be passed to SDL_RWops (this example is 
assuming you want to load an image to a surface and loading it to a texture):
{% highlight c++ linenos %}
int LoadAsset(const std::string Asset)
{
	OpenFile(Asset.c_str());
    SDL_RWops *RW = SDL_RWFromMem(Data, Size);
    SDL_Surface *TempSurface = IMG_Load_RW(RW,0);
    SDL_Texture *OptTexture = SDL_CreateTextureFromSurface(renderer, TempSurface);
    return 0;
}
{% endhighlight %}

### 4. Freeing memory
With the provided functions memory is being used but not freed and memory leaks 
are bad.
{% highlight c++ linenos %}
int FreeMemory()
{
	SDL_FreeSurface(TempSurface);
    SDL_FreeRW(RW);
    SDL_DestroyTexture(OptTexture);
    delete[] Data;
    return 0;
}
{% endhighlight %}

### Using everything together

{% highlight c++ linenos %}
SetArchive("Content/test.zip");
LoadAsset("testimage.png");
FreeMemory();
{% endhighlight %}
These functions serve only as a way to get the general idea across for loading 
an asset from compressed file to memory, and then finally to video memory.
