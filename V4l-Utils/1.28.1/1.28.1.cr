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
                                    -Dgconv=disabled                        \
                                    -Ddoxygen-doc=disabled",
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

        if !option("Qv4l2")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/qv4l2")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/applications/qv4l2.desktop")
        end

        if !option("Qvidcap")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/qvidcap")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/applications/qvidcap.desktop")
        end
    end

end
