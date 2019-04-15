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

        renderers.current.renderLimit = 1
        renderers.current.passLimit = 300

        rendered_image_path = "{output_path}" + "\\converted_" + maxFileName + ".jpg"

        rstart = timeStamp()
        render outputfile:rendered_image_path
        rend = timeStamp()
        relapsed = ((rend - rstart) / 1000.0)

        file_path = "{output_path}\\..\\" + maxFileName + ".render_time.log"
        a = (createFile file_path mode:"w")
        line = (relapsed as string)
        format "%" line to:a
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
