class Target < ISM::Software

    def prepare
        super

        runAutoreconfCommand(   arguments: "-fiv",
                                path: buildDirectoryPath)
    end

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

    def deploy
        if autoDeployServices
            if option("Openrc")
                runRcUpdateCommand("add alsasound boot")
            end
        end
    end

end
