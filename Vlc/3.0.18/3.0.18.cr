class Target < ISM::Software

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--disable-libva"],
                            path: buildDirectoryPath,
                            environment: {  "LUAC" => "/usr/bin/luac5.2",
                                            "LUA_LIBS" => "\"$(pkg-config --libs lua52)\"",
                                            "CPPFLAGS" => "\"$(pkg-config --cflags lua52)\"",
                                            "BUILDCC" => "gcc"})
    end

    def build
        super

        makeSource( path: buildDirectoryPath.
                    environment: {  "LUAC" => "/usr/bin/luac5.2",
                                            "LUA_LIBS" => "\"$(pkg-config --libs lua52)\"",
                                            "CPPFLAGS" => "\"$(pkg-config --cflags lua52)\"",
                                            "BUILDCC" => "gcc"})
    end

    def prepareInstallation
        super

        makeSource( ["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],
                    path: buildDirectoryPath,
                    environment: {  "LUAC" => "/usr/bin/luac5.2",
                                            "LUA_LIBS" => "\"$(pkg-config --libs lua52)\"",
                                            "CPPFLAGS" => "\"$(pkg-config --cflags lua52)\"",
                                            "BUILDCC" => "gcc"})
    end

    def install
        super

        runGtkUpdateIconCacheCommand(["-qtf","/usr/share/icons/hicolor"])
        runUpdateDesktopDatabaseCommand(["-q"])
    end

end
