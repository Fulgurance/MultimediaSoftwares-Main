class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr                                      \
                                    --enable-gpl                                        \
                                    --enable-version3                                   \
                                    --enable-nonfree                                    \
                                    --disable-static                                    \
                                    --enable-shared                                     \
                                    --disable-debug                                     \
                                    #{option("Libaom") ? "--enable-libaom" : ""}        \
                                    #{option("Libass") ? "--enable-libass" : ""}        \
                                    #{option("Fdk-Aac") ? "--enable-libfdk-aac" : ""}   \
                                    --enable-libfreetype                                \
                                    #{option("Lame") ? "--enable-libmp3lame" : ""}      \
                                    #{option("Opus") ? "--enable-libopus" : ""}         \
                                    #{option("Libtheora") ? "--enable-libtheora" : ""}  \
                                    --enable-libvorbis                                  \
                                    #{option("Libvpx") ? "--enable-libvpx" : ""}        \
                                    #{option("X264") ? "--enable-libx264" : ""}         \
                                    #{option("X265") ? "--enable-libx265" : ""}         \
                                    --enable-openssl                                    \
                                    --docdir=/usr/share/doc/ffmpeg-6.0",
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

    def install
        super

        runChmodCommand("0755 /usr/bin/qt-faststart")
    end

end
