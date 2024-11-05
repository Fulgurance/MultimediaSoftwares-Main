class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--disable-alsaconf \
                                    --disable-bat       \
                                    --disable-xmlto     \
                                    --with-curses=ncursesw",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        if option("Openrc")
            prepareOpenrcServiceInstallation(   path:   "#{workDirectoryPath}/Alsasound-Init.d",
                                                name:   "alsasound")
        end
    end

    def install
        super

        runAlsactlCommand("-L store")
    end

end
