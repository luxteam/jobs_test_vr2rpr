resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderVray.log"
units.SystemType = #Meters

function main = (
    vray_cpu = V_Ray_Next__update_1_2()
    vray_gpu = V_Ray_GPU_Next__update_1_2()
    vray_default_log_file = "C:\\Users\\" + sysInfo.username + "\\AppData\\Local\\Temp\\vraylog.txt"

    filesToRender = #(
        {scene_list}
    )

    renderersForFiles = #(
        {render_list}
    )

    for fi=1 to filesToRender.count do (
        scene_path = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile scene_path useFileUnits:true quiet:true

        if classof renderers.current != classof renderersForFiles[fi] do (
            renderers.current = renderersForFiles[fi]
        )

        vr = renderers.current
        setVRaySilentMode()

        vr.system_vrayLog_level = 4

        rendered_image_path = "{output_path}" + "\\Color\\" + maxFileName + ".jpg"
        rendered_image_log_path = "{output_path}" + "\\" + maxFileName + ".or.log"
        render outputfile:rendered_image_path

        copyFile vray_default_log_file rendered_image_log_path
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
