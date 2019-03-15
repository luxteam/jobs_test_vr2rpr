import os
import maya.cmds as cmds
import maya.mel as mel
import convertAI2RPR
import datetime
import json


def rpr_render(scene):
    cmds.optionVar(rm="RPR_DevicesSelected")
    cmds.optionVar(iva=("RPR_DevicesSelected", 1))

    cameras = cmds.ls(cameras=True)
    if ("cameraShape1" in cameras):
        mel.eval("lookThru camera1")
    else:
        print("[ERROR]: no camera1\n")

    cmds.fireRender(waitForItTwo=True)

    mel.eval("renderIntoNewWindow render")
    output = os.path.join("{work_dir}", "Color", "converted_" + scene)
    cmds.renderWindowEditor("renderView", edit=True, dst="color")
    cmds.renderWindowEditor("renderView", edit=True, com=True, writeImage=output)


def prerender(scene, rpr_iter):
    scene_name = cmds.file(q=True, sn=True, shn=True)
    print("\n\n--------\n")
    print("Processing: " + scene_name + "\n")
    if scene_name != scene:
        try:
            cmds.file(scene, f=True, options="v=0;", ignoreVersion=True, o=True)
        except:
            print("Failed to open scene")
            exit(1)

    if not cmds.pluginInfo("mtoa", q=True, loaded=True):
        cmds.loadPlugin("mtoa")

    if not cmds.pluginInfo("RadeonProRender", q=True, loaded=True):
        cmds.loadPlugin("RadeonProRender")

    convertAI2RPR.auto_launch()

    print("Conversion finished.\n")

    cmds.setAttr("defaultRenderGlobals.currentRenderer", "FireRender", type="string")
    cmds.setAttr("defaultRenderGlobals.imageFormat", 8)
    cmds.setAttr("RadeonProRenderGlobals.completionCriteriaIterations", rpr_iter)

    rpr_render(scene)
    print("Render finished.\n")

    filePath = "{work_dir}" + "/" + scene + "_RPR.json"
    report = {{}}
    report['render_device'] = cmds.optionVar(q="RPR_DevicesName")[0]
    report['tool'] = "Maya " + cmds.about(version=True)
    report['date_time'] = datetime.datetime.now().strftime("%m/%d/%Y %H:%M:%S")
    report['render_version'] = mel.eval("getRPRPluginVersion()")
    report['core_version'] = mel.eval("getRprCoreVersion()")
    report['file_name'] = "converted_" + scene + ".jpg"
    report['render_color_path'] = "Color/converted_" + scene + ".jpg"
    report['scene_name'] = scene
    report['render_time'] = 1
    report['test_case'] = scene
    report['difference_color'] = "not compared yet"
    report['test_status'] = "passed"

    with open(filePath, 'w') as file:
        json.dump([report], file, indent=4)


def main():


    tests = {tests}
    for each in tests:
        prerender(each, 300)

    cmds.evalDeferred(cmds.quit(abort=True))
