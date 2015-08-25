if (APPLE)

  set (RESOURCES ${JOLLYROGER_SOURCE_DIR}/../Resources/share/Icon.png) 
  set_source_files_properties (${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
  set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")

  if (IOS_PLATFORM)

    set (IOS_FRAMEWORKS
         Foundation
         AudioToolbox
         CoreGraphics
         QuartzCore
         UIKit
         OpenGLES
    )

    foreach (FW ${IOS_FRAMEWORKS})
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
    endforeach ()

    include_directories (${SDL2_INCLUDE})
    link_directories (${SDL2_LIBRARY})

  else () # MACOSX_PLATFORM
    link_libraries (${SDL2_LIBRARY})
  endif ()
endif (APPLE)

include_directories (${SDL2_INCLUDE} ${HEADERS})

if (APPLE)
  add_executable (JollyRoger
                  MACOSX_BUNDLE
                  main.cpp
                  ${RESOURCES}
  )
else ()
  add_executable (JollyRoger
                  main.cpp
)

endif ()

target_link_libraries(JollyRoger GFXLib SDL2)
