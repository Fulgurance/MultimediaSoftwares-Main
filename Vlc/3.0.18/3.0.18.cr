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

        #Optional: to run to improve performance but only if that command is installed
        #runGtkUpdateIconCacheCommand("-qtf /usr/share/icons/hicolor")
        #runUpdateDesktopDatabaseCommand("-q")
    end

end
