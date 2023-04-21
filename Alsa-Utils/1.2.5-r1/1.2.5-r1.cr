class Target < ISM::Software

    def configure
        super

        configureSource([   "--disable-alsaconf",
                            "--disable-bat",
                            "--disable-xmlto",
                            "--with-curses=ncursesw"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        if option("Openrc")
            makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d")
            moveFile("#{workDirectoryPath(false)}/alsasound.initd-r8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/init.d/alsasound")
            runChmodCommand(["+x","alsasound"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/init.d")
        end
    end

end
