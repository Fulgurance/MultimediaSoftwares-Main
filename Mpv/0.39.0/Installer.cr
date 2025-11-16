class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand(arguments:  "setup                                  \
                                    --reconfigure                           \
                                    #{@buildDirectoryNames["MainBuild"]}    \
                                    --prefix=/usr                           \
                                    --buildtype=release                     \
                                    -Dx11=enabled",
                        path:       mainWorkDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(arguments:      "install",
                        path:           buildDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
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
