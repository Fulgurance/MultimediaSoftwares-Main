class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand([   "setup",
                            "--reconfigure",
                            @buildDirectoryNames["MainBuild"],
                            "--prefix=/usr",
                            "--buildtype=release",
                            "-Ddatabase=gdbm",
                            "-Ddoxygen=false",
                            "-Dbluez5=disabled"],
                            mainWorkDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})

        if option("Dbus")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/dbus-1/system.d/pulseaudio-system.conf")
        end
    end

end
