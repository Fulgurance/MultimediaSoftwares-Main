class Target < ISM::Software

    def prepare
        super

        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}configure","-lflite\"","-lflite -lasound\"",6363)
    end

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--enable-gpl",
                            "--enable-version3",
                            "--enable-nonfree",
                            "--disable-static",
                            "--enable-shared",
                            "--disable-debug",
                            "--enable-avresample",
                            "#{option("Libass") ? "--enable-libass" : ""}",
                            "#{option("Fdk-Aac") ? "--enable-libfdk-aac" : ""}",
                            "--enable-libfreetype",
                            "#{option("Lame") ? "--enable-libmp3lame" : ""}",
                            "#{option("Opus") ? "--enable-libopus" : ""}",
                            "#{option("Libtheora") ? "--enable-libtheora" : ""}",
                            "--enable-libvorbis",
                            "--enable-libvpx",
                            "--enable-libx264",
                            "--enable-libx265",
                            "--enable-openssl",
                            "--docdir=/usr/share/doc/ffmpeg-4.4"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
        runGccCommand(["tools/qt-faststart.c","-o","tools/qt-faststart"],buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/bin")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/ffmpeg-4.4")

        copyFile("#{buildDirectoryPath(false)}tools/qt-faststart","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/bin/qt-faststart")

        Dir["#{buildDirectoryPath(false)}doc/*.txt"].each do |filepath|
            filename = filepath.lchop(filepath[0..filepath.rindex("/")])
            destination = "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/ffmpeg-4.4/#{filename}"

            copyFile(filepath,destination)
            setPermissions(destination,0o644)
        end
    end

    def install
        super

        setPermissions("#{Ism.settings.rootPath}usr/bin/qt-faststart",0o755)
        setPermissions("#{Ism.settings.rootPath}usr/share/doc/ffmpeg-4.4",0o755)
    end

end
