class Target < ISM::Software

    def configure
        super

        configureSource(arguments:      "--prefix=/usr  \
                                        --disable-libva \
                                        --disable-lua   \
                                        --disable-a52   \
                                        --disable-libplacebo    \
                                        --disable-xcb   \
                                        #{option("Alsa-Lib") ? "--enable-alsa" : "--disable-alsa"}  \
                                        #{option("Qt") ? "--enable-qt" : "--disable-qt"}  \
                                        #{option("Ffmpeg") ? "--enable-avcodec" : "--disable-avcodec"}",
                        path:           buildDirectoryPath,
                        environment:    {"BUILDCC" => "gcc"})
    end

    def build
        super

        makeSource( path: buildDirectoryPath,
                    environment: {"BUILDCC" => "gcc"})
    end

    def prepareInstallation
        super

        makeSource( arguments:      "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:           buildDirectoryPath,
                    environment:    {"BUILDCC" => "gcc"})

        if !option("Qt")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/applications/vlc.desktop")
        end
    end

    def install
        super

        if softwareIsInstalled("@GraphicsLibraries-Main:Gtk")
            runGtkUpdateIconCacheCommand("-qtf /usr/share/icons/hicolor")
        end

        if softwareIsInstalled("@Utilities-Main:Desktop-File-Utils")
            runUpdateDesktopDatabaseCommand("-q")
        end
    end

end
