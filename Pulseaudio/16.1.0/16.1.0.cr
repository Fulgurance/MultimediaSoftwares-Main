class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        runMesonCommand(["setup",@buildDirectoryNames["MainBuild"],"-Ddatabase=gdbm","-Ddoxygen=false",],mainWorkDirectoryPath)
    end

    def configure
        super

        runMesonCommand([   "configure",
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

        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/dbus-1/system.d/pulseaudio-system.conf")
    end

end
