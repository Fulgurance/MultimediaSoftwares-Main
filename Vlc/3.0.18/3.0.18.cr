class Target < ISM::Software

    def configure
        super

        configureSource(arguments:      "--prefix=/usr  \
                                        --disable-libva \
                                        --disable-lua   \
                                        --disable-a52",
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

        if softwareIsInstalled("Gtk+")
            runGtkUpdateIconCacheCommand("-qtf /usr/share/icons/hicolor")
        end

        if softwareIsInstalled("Desktop-File-Utils")
            runUpdateDesktopDatabaseCommand("-q")
        end
    end

end
