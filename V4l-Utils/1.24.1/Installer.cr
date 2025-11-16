class Target < ISM::Software

    def configure
        super

        configureSource(arguments:      "--prefix=/usr      \
                                        --sysconfdir=/etc   \
                                        --disable-static",
                        path:           buildDirectoryPath)
    end

    def build
        super

        makeSource( path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:      "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:           buildDirectoryPath)

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
