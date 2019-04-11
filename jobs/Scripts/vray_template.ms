resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderVray.log"
units.SystemType = #Meters

function main = (
    vray_cpu = V_Ray_Next__update_1_2()
    vray_gpu = V_Ray_GPU_Next__update_1_2()

    filesToRender = #(
        {scene_list}
    )

    renderersForFiles = #(
        {render_list}
    )

    for fi=1 to filesToRender.count do (
        scene_path = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile scene_path useFileUnits:true quiet:true

        renderers.current = renderersForFiles[fi]

        vr = renderers.current
        setVRaySilentMode()

        --save to json
        --vrayVersion()

        --vr.output_saveFile=true
        --vr.output_on=false
        --vr.system_vrayLog_file = "D://vray_renderr.log"
        --vr.system_vrayLog_level = 1
        --vr.output_fileOnly = true
        --vr.system_vrayLog_show = 0
        rendered_image_path = "{output_path}" + "\\" + maxFileName + ".jpg"
        render outputfile:rendered_image_path
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
