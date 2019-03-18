global autoLaunch = "true"

include "vray2rpr.ms"
resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderTool.log"
units.SystemType = #Meters

function main = (
    filesToRender = #(
        {scene_list}
    )

    for fi=1 to filesToRender.count do (
        scene_path = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile scene_path useFileUnits:true quiet:true

        convertScene()

        renderers.current = Radeon_ProRender()
        renderers.current.renderLimit = 1
        renderers.current.passLimit = 300

        rendered_image_path = "{output_path}" + "\\converted_" + maxFileName + ".png"
        render outputfile:rendered_image_path
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
