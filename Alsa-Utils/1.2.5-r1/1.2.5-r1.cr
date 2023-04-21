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
    end

end
