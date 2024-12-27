class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr            \
                                    -DCMAKE_BUILD_TYPE=Release              \
                                    -DAUDACITY_BUILD_LEVEL=2                \
                                    -Daudacity_has_networking=off           \
                                    -Daudacity_conan_enabled=off            \
                                    -Daudacity_has_updates_check=off        \
                                    -Daudacity_has_audiocom_upload=off      \
                                    -Daudacity_has_sentry_reporting=off     \
                                    -Daudacity_has_crashreports=off         \
                                    -Daudacity_has_tests=off                \
                                    -Daudacity_lib_preference=system        \
                                    -Daudacity_obey_off_dependencies=on     \
                                    -Daudacity_use_expat=off                \
                                    -Daudacity_use_ffmpeg=off               \
                                    -Daudacity_use_libid3tag=off            \
                                    -Daudacity_use_ladspa=off               \
                                    -Daudacity_use_lame=off                 \
                                    -Daudacity_use_wxwidgets=system         \
                                    -Daudacity_use_libflac=off              \
                                    -Daudacity_use_libmp3lame=off           \
                                    -Daudacity_use_libmpg123=off            \
                                    -Daudacity_use_libogg=off               \
                                    -Daudacity_use_libopus=off              \
                                    -Daudacity_use_libsndfile=off           \
                                    -Daudacity_use_libvorbis=off            \
                                    -Daudacity_use_lv2=off                  \
                                    -Daudacity_use_midi=off                 \
                                    -Daudacity_use_nyquist=local            \
                                    -Daudacity_use_opusfile=off             \
                                    -Daudacity_use_pch=off                  \
                                    -Daudacity_use_portaudio=off            \
                                    -Daudacity_use_portmixer=off            \
                                    -Daudacity_use_portsmf=off              \
                                    -Daudacity_use_rapidjson=off            \
                                    -Daudacity_use_sbsms=off                \
                                    -Daudacity_use_soundtouch=off           \
                                    -Daudacity_use_soxr=off                 \
                                    -Daudacity_use_twolame=off              \
                                    -Daudacity_use_vamp=off                 \
                                    -Daudacity_use_wavpack=off              \
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
