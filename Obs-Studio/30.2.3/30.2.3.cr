class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr    \
                                    -DCMAKE_BUILD_TYPE=Release      \
                                    -DENABLE_SCRIPTING=OFF          \
                                    -DBUILD_BROWSER=OFF             \
                                    -DENABLE_WEBSOCKET=OFF          \
                                    -DENABLE_NEW_MPEGTS_OUTPUT=OFF  \
                                    -DENABLE_NATIVE_NVENC=OFF       \
                                    -DENABLE_SPEEXDSP=OFF           \
                                    -DENABLE_AJA=OFF                \
                                    -DENABLE_WEBRTC=OFF             \
                                    -DENABLE_VLC=OFF                \
                                    ..",
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
    end

end
