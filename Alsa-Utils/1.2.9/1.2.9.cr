class Target < ISM::Software

    def prepare
        super

        deleteFile("#{mainWorkDirectoryPath(false)}/alsactl/init_sysdeps.c")
        generateEmptyFile("#{mainWorkDirectoryPath(false)}/alsactl/init_sysdeps.c")
    end

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
            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/Alsasound-Init.d","alsasound")
        end
    end

    def install
        super

        runAlsactlCommand(["-L","store"])
    end

end
