class Target < ISM::Software

    def configure
        super

        configureSource(arguments:      "--prefix=/usr  \
                                        --disable-libva \
                                        --disable-lua   \
                                        --disable-a52   \
                                        #{option("Qt") ? "--enable-qt" : "--disable-qt"}  \
                                        #{option("Ffmpeg") ? "" : "--disable-avcodec"}",
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
