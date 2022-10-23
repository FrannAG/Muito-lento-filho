--Stage Vars
local zoom = false;
local isPixel = false;
local dadFloat = false;
--Modchart Vars
local defaultNotePos = {};
local cambeating = false;
local beatStep = 4;
local arrowAngleBeating = false;
local noArrowBump = true;
local arrowAngle = 4;
local hudShake = false;
local hudShakeSmall = false;
local shakearrow = false;
local shakearrow2 = false;
local shakearrow3 = false;
local shakearrow4 = false;
local shakearrow5 = false;
local shakearrow6 = false;
local shakearrow7 = false;
local shakeangle = false;
local hudXmove = false;
local hudYmove = false;
local Xforce = 12;
local Yforce = 12;

function onCreate()
    addCharacterToList('sonic_exe', 'dad');
    addCharacterToList('sonic_exe_pixel','dad');
    addCharacterToList('sonic_exe_pixel_alt','dad');
    addCharacterToList('bf-pixel','bf');
    addCharacterToList('bf-pixel-alt','bf');
    addCharacterToList('gf-pixel','gf');
    addCharacterToList('gf-pixel-alt','gf');
    makeLuaSprite('black','BlackBg',-350,0,0.9);
    makeLuaSprite('blackfinal','BlackBg',-350,0,0);
    addLuaSprite('black',true);
end

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')


        table.insert(defaultNotePos, {x, y, angle})
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if zoom then
        setCamZoom('cam',1.2);
    end

    if dadFloat then
        setProperty('dad.y',32*math.cos(currentBeat));
    end

    if cambeating and curStep % beatStep == 0 then
        if isPixel then
            setCamZoom('cam',0.85);
            setCamZoom('hud',1.05);
            if noArrowBump == false then
                setCamZoom('arrow',1.05);
            end
        else
            if zoom == false then
                setCamZoom('cam',1.05);
            end
            setCamZoom('hud',1.05);
            if noArrowBump == false then
                setCamZoom('arrow',1.05);
            end
        end
    end

    if hudShake then
        hudAngle = 2*math.sin(currentBeat) * math.pi;
    end

    if hudShakeSmall then
        hudAngle = 4*math.sin(currentBeat);
    end

    if hudXmove then
        setProperty('camHUD.x', Xforce*math.sin(currentBeat)*math.pi);
        setProperty('arrowCAM.x', Xforce*math.sin(currentBeat)*math.pi);
    end

    if hudYmove then
        setProperty('camHUD.y', Yforce*math.cos(currentBeat)*math.pi);
        setProperty('arrowCAM.y', Yforce*math.cos(currentBeat)*math.pi);
    end

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 7 * math.sin((currentBeat + i*0.25) * math.pi))
        end
    end
    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 7 * math.sin((currentBeat + i*0.25) * math.pi))
        end
    end
    if shakearrow3 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 10 * math.sin((currentBeat + i*1) * math.pi))
        end
    end
    if shakearrow4 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 20 * math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][3] + 32 * math.sin((currentBeat + i*0.25)))
        end
    end
    if shakearrow5 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 0 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 15 * math.sin((currentBeat + i*1) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][3] + 0 * math.sin((currentBeat + i*0)))
        end
    end
    if shakearrow6 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.sin((currentBeat + i*0)))
        end
    end
    if shakearrow7 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.sin((currentBeat + i*0) * math.pi));
        end
    end
    if shakeangle then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][3] + 10 * math.sin((currentBeat + i*1) * math.pi))
        end
    end
end

function onStepHit()
    --Modchart By Step
    if arrowAngleBeating and curStep % 4 == 0 then
        arrowAngleBeat(1.13);
    end
    --CurStep
    if curStep == 384 then
        cameraFlash('hud','FFFFFF',1,false);
        for i=0,7 do
            noteTweenAlpha("movementAlpha " .. i, i, 0, 0.1, "linear");
        end
        showOnlyStrums = true;
        setProperty('boyfriend.alpha',0);
        setProperty('dad.alpha',0);
        setProperty('gf.alpha',0);
        doTweenAlpha("tween4", 'black', 1, 0.1, "linear");
        removeLuaSprite('black',false);
        addLuaSprite('black',false);
        changeCharacter('sonic_exe');
        setProperty('dad.alpha',0);
        zoom = true;
    end
    if curStep == 400 then
        doTweenAlpha("tween", 'dad', 1, 1, "linear");
        cameraFlash('hud','FF0000',1,false);
    end
    if curStep == 416 then
        showOnlyStrums = false;
        zoom = false;
        cambeating = true;
        arrowAngleBeating = true;
        removeLuaSprite('black',true);
        cameraFlash('hud','FFFFFF',1,false);
        goToPixel(false,false);
        setProperty('boyfriend.alpha',1);
        setProperty('gf.alpha',1);
    end
    if curStep == 544 then
        arrowAngleBeating = false;
        noArrowBump = false;
        forceAngleArrow = false;
        shakearrow = true;
        cameraFlash('hud','FF0000',1,false);
        goToPixel(true);
    end
    if curStep == 1312 then
        shakearrow7 = false;
        hudShakeSmall = false;
        hudAngle = 0;
        resetStaticArrows(0.6);
        cameraFlash('hud','FF0000',1,false);
        goToPixel(false,true);
    end
    if curStep == 1472 or curStep == 1478 or curStep == 1484 or curStep == 1490 or curStep == 1494 or curStep == 1496 or curStep == 1500 then
        cambeating = false;
        cameraFlash('hud','FFFFFF',0.3,true);
        setCamZoom('hud',1.2);
        setCamZoom('arrow',1.2);
    end
    if curStep == 1504 then
        cambeating = true;
        cameraFlash('hud','FF0000',1,true);
        goToPixel(true,true);
        hudXmove = true;
        hudYmove = true;
        shakearrow6 = true;
    end
    if curStep == 672 then
        cameraFlash('hud','FFFFFF',0.6,false);
        shakearrow = false;
        resetStaticArrows(0.6);
        zoom = true;
    end
    if curStep == 688 or curStep == 752 then
        setCamAngle('cam',-25);
        hudAngle = -25;
    end
    if curStep == 692 or curStep == 756 then
        setCamAngle('cam',25);
        hudAngle = 25;
    end
    if curStep == 703 or curStep == 768 then
        setCamAngle('cam',0);
        hudAngle = 0;
        zoom = false;
        shakearrow2 = true;
    end
    if curStep == 736 then
        cameraFlash('hud','FFFFFF',0.6,false);
        shakearrow2 = false;
        resetStaticArrows(0.6);
        zoom = true;
    end
    if curStep == 800 then
        shakearrow2 = false;
        hudShake = true;
        shakearrow3 = true;
    end
    if curStep == 864 then
        shakeangle = true;
        hudYmove = true;
    end
    if curStep == 928 then
        hudShake = false;
        hudAngle = 0;
        shakearrow3 = false;
        shakeangle = false;
        hudYmove = false;
        resetCamPosition();
        resetStaticArrows(0.6);
        cambeating = false;
        for i=0,7 do
            noteTweenAlpha("movementAlpha " .. i, i, 0, 0.1, "linear");
        end
        showOnlyStrums = true;
    end
    if curStep == 985 then
        cameraShake('cam',0.02,0.92)
    end
    if curStep == 1056 then
        if middlescroll == false then
            for i=0,7 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.1, "linear");
            end
        else
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.1, "linear");
            end
            for i=4,7 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.1, "linear");
            end
        end
        showOnlyStrums = false;
        cambeating = true;
        shakearrow2 = true;
        hudXmove = true;
    end
    if curStep == 1184 then
        shakearrow2 = false;
        hudXmove = false;
        resetCamPosition();
        shakearrow7 = true;
        hudShakeSmall = true;
    end
    if curStep == 1664 or curStep == 1728 then
        hudShake = true;
        shakearrow6 = false;
        shakearrow3 = true;
    end
    if curStep == 1696 then
        hudShake = false;
        hudAngle = 0;
        shakearrow3 = false;
        shakearrow6 = true;
    end
    if curStep == 1760 then
        hudShake = false;
        hudAngle = 0;
        shakearrow3 = false;
        shakearrow6 = false;
        hudXmove = false;
        resetCamPosition();
        shakearrow5 = true;
    end
    if curStep == 1761 then
        beatStep = 5;
    end
    if curStep == 1824 then
        shakearrow5 = false;
        shakearrow4 = true;
    end
    if curStep == 1888 then
        shakearrow4 = false;
        shakearrow5 = true;
    end
    if curStep == 1952 then
        shakearrow5 = false;
        shakearrow4 = true;
        hudXmove = true;
    end
    if curStep == 2016 then
        cambeating = false;
        shakearrow4 = false;
        hudXmove = false;
        hudYmove = false;
        resetStaticArrows(1);
        resetCamPosition();
        addLuaSprite('blackfinal',true);
        doTweenAlpha("finaltween", 'blackfinal', 1, 3, "linear");
    end
end
--Stage Functions
function goToPixel(goBack,phase2)
    if goBack == false then
        setProperty('sky.visible',false);
        setProperty('hills.visible',false);
        setProperty('ground.visible',false);
        setProperty('ground2.visible',false);
        setProperty('tail.visible',false);
        setProperty('eggman.visible',false);
        setProperty('k.visible',false);
        setProperty('stick.visible',false);
        setProperty('ground_pixel.visible',true);
        if phase2 == false then
            isPixel = true;
            setProperty('defaultCamZoom',0.8);
            setProperty('pixel_bg.visible',true);
            changeCharacter('sonic_exe_pixel');
            changeCharacter('bf-pixel-alt');
            changeCharacter('gf-pixel-alt');
        else
            setProperty('pixel_bg2.visible',true);
            changeCharacter('sonic_exe_pixel_alt');
            changeCharacter('bf-pixel');
            changeCharacter('gf-pixel');
        end
    else
        if phase2 == true then
            dadFloat = false;
        else
            isPixel = false;
        end
        setProperty('defaultCamZoom',1.0);
        setProperty('sky.visible',true);
        setProperty('hills.visible',true);
        setProperty('ground.visible',true);
        setProperty('ground2.visible',true);
        setProperty('tail.visible',true);
        setProperty('eggman.visible',true);
        setProperty('k.visible',true);
        setProperty('stick.visible',true);
        setProperty('ground_pixel.visible',false);
        setProperty('pixel_bg.visible',false);
        setProperty('pixel_bg2.visible',false);
        changeCharacter('bf');
        changeCharacter('sonic_exe');
        changeCharacter('gf');
    end
end

function changeCharacter(char)
    if char == 'sonic_exe' then
        resetDadposition();
        triggerEvent('Change Character', 'dad', 'sonic_exe');
        setProperty('dad.scale.x',1.1);
        setProperty('dad.scale.y',1.1);
        setProperty('dad.x',getProperty('dad.x') -130 + 200);
        setProperty('dad.y',getProperty('dad.y') -50 + 200);
    elseif char == 'sonic_exe_pixel' then
        resetDadposition();
        triggerEvent('Change Character', 'dad', 'sonic_exe_pixel');
        setProperty('dad.scale.x',12);
        setProperty('dad.scale.y',12);
        setProperty('dad.y',getProperty('dad.y') +262);
    elseif char == 'bf-pixel-alt' then
        resetBfPosition();
        triggerEvent('Change Character', 'bf', 'bf-pixel-alt');
    elseif char == 'bf-pixel' then
        resetBfPosition();
        triggerEvent('Change Character', 'bf', 'bf-pixel');
    elseif char == 'sonic_exe_pixel_alt' then
        resetDadposition();
        triggerEvent('Change Character', 'dad', 'sonic_exe_pixel_alt');
        dadFloat = true;
    elseif char == 'bf' then
        resetBfPosition();
        triggerEvent('Change Character', 'bf', 'bf');
        setProperty('bf.y',getProperty('boyfriend.y') +25);
    elseif char == 'gf-pixel-alt' then
        resetGfPosition();
        triggerEvent('Change Character', 'gf', 'gf-pixel-alt');
        setProperty('gf.x',getProperty('gf.x') + 70);
        setProperty('gf.y',getProperty('gf.y') + 150);
    elseif char == 'gf' then
        resetGfPosition();
        triggerEvent('Change Character', 'gf', 'gf');
    elseif char == 'gf-pixel' then
        resetGfPosition();
        triggerEvent('Change Character', 'gf', 'gf-pixel');
        setProperty('gf.x',getProperty('gf.x') + 70);
        setProperty('gf.y',getProperty('gf.y') + 180);
    end
end

function resetDadposition()
    setProperty('dad.x',100);
    setProperty('dad.y',100);
end

function resetBfPosition()
    setProperty('bf.x',770);
    setProperty('bf.y',100);
end

function resetGfPosition()
    setProperty('gf.x',400);
    setProperty('gf.y',130);
end

--Modchart Functions
function arrowAngleBeat(zoomForce)
    setCamAngle('arrow',arrowAngle);
    setCamZoom('arrow',zoomForce);
    arrowAngle = arrowAngle *-1;
end

function resetStaticArrows(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], time, "linear");
    end
end

function resetCamPosition()
    setProperty('camHUD.x',0);
    setProperty('camHUD.y',0);
    setProperty('arrowCAM.x',0);
    setProperty('arrowCAM.y',0);
end