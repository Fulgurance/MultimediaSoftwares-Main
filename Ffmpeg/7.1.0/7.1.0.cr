class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr                                          \
                                    --enable-gpl                                            \
                                    --enable-version3                                       \
                                    --enable-nonfree                                        \
                                    --disable-static                                        \
                                    --enable-shared                                         \
                                    --disable-debug                                         \
                                    #{option("Libaom") ? "--enable-libaom" : ""}            \
                                    #{option("Libass") ? "--enable-libass" : ""}            \
                                    #{option("Fdk-Aac") ? "--enable-libfdk-aac" : ""}       \
                                    #{option("FreeType") ? "--enable-libfreetype " : ""}    \
                                    #{option("Lame") ? "--enable-libmp3lame" : ""}          \
                                    #{option("Opus") ? "--enable-libopus" : ""}             \
                                    #{option("Libtheora") ? "--enable-libtheora" : ""}      \
                                    #{option("Libvorbis") ? "--enable-libvorbis" : ""}      \
                                    #{option("Libvpx") ? "--enable-libvpx" : ""}            \
                                    #{option("X264") ? "--enable-libx264" : ""}             \
                                    #{option("X265") ? "--enable-libx265" : ""}             \
                                    #{option("Opencl-Headers") ? "--enable-opencl" : ""}    \
                                    #{option("Mesa") ? "--enable-opencl" : ""}              \
                                    #{option("Nv-Codec-Headers") ? "--enable-nvdec" : ""}   \
                                    #{option("Opencl-Headers") ? "--enable-nvenc" : ""}     \
                                    --enable-openssl                                        \
                                    #{option("Nasm") || option("Yasm") ? "--enable-asm" : "--disable-asm"}  \
                                    --docdir=/usr/share/doc/#{versionName}",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)

        runGccCommand(  arguments:  "tools/qt-faststart.c -o tools/qt-faststart",
                        path:       buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/bin")

        copyFile(   "#{buildDirectoryPath}tools/qt-faststart",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/bin/qt-faststart")
    end

end
