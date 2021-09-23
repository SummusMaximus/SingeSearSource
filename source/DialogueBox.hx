package;

import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitSearA:FlxSprite;
	var portraitSearB:FlxSprite;
	var portraitSearC:FlxSprite;
	var portraitSingeA:FlxSprite;
	var portraitSingeB:FlxSprite;
	var portraitSingeC:FlxSprite;
	var portraitSingeD:FlxSprite;
	var portraitSingeE:FlxSprite;
	var portraitSingeF:FlxSprite;
	var portraitSingeG:FlxSprite;
	var portraitSingeH:FlxSprite;
	var portraitSingeI:FlxSprite;
	var portraitSingeJ:FlxSprite;
	var portraitSingeK:FlxSprite;
	var portraitSingeL:FlxSprite;
	var portraitSingeM:FlxSprite;
	var portraitSearjar:FlxSprite;
	var portraitBfA:FlxSprite;
	var portraitBfB:FlxSprite;
	var portraitBfC:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	var sound:FlxSound;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				sound = new FlxSound().loadEmbedded(Paths.music('Lunchbox'),true);
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'thorns':
				sound = new FlxSound().loadEmbedded(Paths.music('LunchboxScary'),true);
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'heartburn':
				FlxG.sound.playMusic(Paths.music('Afterdia'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'idk-love':
				FlxG.sound.playMusic(Paths.music('SingeDIA'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'molotov':
				FlxG.sound.playMusic(Paths.music('Afterdia'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'seared':
				FlxG.sound.playMusic(Paths.music('SearDIA'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
		case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'idk-love':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'heartburn':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'seared':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'molotov':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
	{	
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
}
if (PlayState.SONG.song.toLowerCase()=='idk-love' || PlayState.SONG.song.toLowerCase()=='heartburn' || PlayState.SONG.song.toLowerCase()=='seared' || PlayState.SONG.song.toLowerCase()=='molotov')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitSearA = new FlxSprite(100, -50);
		portraitSearA.frames = Paths.getSparrowAtlas('Singe/seartalk_assets');
		portraitSearA.animation.addByPrefix('enter', 'SeartalkA', 24, false);
		portraitSearA.updateHitbox();
		portraitSearA.scrollFactor.set();
		add(portraitSearA);
		portraitSearA.visible = false;

		portraitSearB = new FlxSprite(100, -50);
		portraitSearB.frames = Paths.getSparrowAtlas('Singe/seartalk_assets');
		portraitSearB.animation.addByPrefix('enter', 'SeartalkB', 24, false);
		portraitSearB.updateHitbox();
		portraitSearB.scrollFactor.set();
		add(portraitSearB);
		portraitSearB.visible = false;

		portraitSearC = new FlxSprite(100, -50);
		portraitSearC.frames = Paths.getSparrowAtlas('Singe/seartalk_assets');
		portraitSearC.animation.addByPrefix('enter', 'SeartalkC', 24, false);
		portraitSearC.updateHitbox();
		portraitSearC.scrollFactor.set();
		add(portraitSearC);
		portraitSearC.visible = false;

		portraitSingeA = new FlxSprite(100, 60);
		portraitSingeA.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeA.animation.addByPrefix('enter', 'SingetalkA', 24, false);
		portraitSingeA.updateHitbox();
		portraitSingeA.scrollFactor.set();
		add(portraitSingeA);
		portraitSingeA.visible = false;

		portraitSingeB = new FlxSprite(100, 60);
		portraitSingeB.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeB.animation.addByPrefix('enter', 'SingetalkB', 24, false);
		portraitSingeB.updateHitbox();
		portraitSingeB.scrollFactor.set();
		add(portraitSingeB);
		portraitSingeB.visible = false;

		portraitSingeC = new FlxSprite(100, 60);
		portraitSingeC.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeC.animation.addByPrefix('enter', 'SingetalkC', 24, false);
		portraitSingeC.updateHitbox();
		portraitSingeC.scrollFactor.set();
		add(portraitSingeC);
		portraitSingeC.visible = false;

		portraitSingeD = new FlxSprite(100, 60);
		portraitSingeD.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeD.animation.addByPrefix('enter', 'SingetalkD', 24, false);
		portraitSingeD.updateHitbox();
		portraitSingeD.scrollFactor.set();
		add(portraitSingeD);
		portraitSingeD.visible = false;

		portraitSingeE = new FlxSprite(100, 60);
		portraitSingeE.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeE.animation.addByPrefix('enter', 'SingetalkE', 24, false);
		portraitSingeE.updateHitbox();
		portraitSingeE.scrollFactor.set();
		add(portraitSingeE);
		portraitSingeE.visible = false;

		portraitSingeF = new FlxSprite(100, 60);
		portraitSingeF.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeF.animation.addByPrefix('enter', 'SingetalkF', 24, false);
		portraitSingeF.updateHitbox();
		portraitSingeF.scrollFactor.set();
		add(portraitSingeF);
		portraitSingeF.visible = false;

		portraitSingeG = new FlxSprite(100, 60);
		portraitSingeG.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeG.animation.addByPrefix('enter', 'SingetalkG', 24, false);
		portraitSingeG.updateHitbox();
		portraitSingeG.scrollFactor.set();
		add(portraitSingeG);
		portraitSingeG.visible = false;

		portraitSingeH = new FlxSprite(100, 60);
		portraitSingeH.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeH.animation.addByPrefix('enter', 'SingetalkH', 24, false);
		portraitSingeH.updateHitbox();
		portraitSingeH.scrollFactor.set();
		add(portraitSingeH);
		portraitSingeH.visible = false;

		portraitSingeI = new FlxSprite(100, 60);
		portraitSingeI.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeI.animation.addByPrefix('enter', 'SingetalkI', 24, false);
		portraitSingeI.updateHitbox();
		portraitSingeI.scrollFactor.set();
		add(portraitSingeI);
		portraitSingeI.visible = false;

		portraitSingeJ = new FlxSprite(100, 60);
		portraitSingeJ.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeJ.animation.addByPrefix('enter', 'SingetalkJ', 24, false);
		portraitSingeJ.updateHitbox();
		portraitSingeJ.scrollFactor.set();
		add(portraitSingeJ);
		portraitSingeJ.visible = false;

		portraitSingeK = new FlxSprite(100, 60);
		portraitSingeK.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeK.animation.addByPrefix('enter', 'SingetalkK', 24, false);
		portraitSingeK.updateHitbox();
		portraitSingeK.scrollFactor.set();
		add(portraitSingeK);
		portraitSingeK.visible = false;

		portraitSingeL = new FlxSprite(100, 60);
		portraitSingeL.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeL.animation.addByPrefix('enter', 'SingetalkL', 24, false);
		portraitSingeL.updateHitbox();
		portraitSingeL.scrollFactor.set();
		add(portraitSingeL);
		portraitSingeL.visible = false;

		portraitSingeM = new FlxSprite(100, 60);
		portraitSingeM.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSingeM.animation.addByPrefix('enter', 'SingetalkM', 24, false);
		portraitSingeM.updateHitbox();
		portraitSingeM.scrollFactor.set();
		add(portraitSingeM);
		portraitSingeM.visible = false;

		portraitSearjar = new FlxSprite(100, 60);
		portraitSearjar.frames = Paths.getSparrowAtlas('Singe/singetalk_assets');
		portraitSearjar.animation.addByPrefix('enter', 'Searjar', 24, false);
		portraitSearjar.updateHitbox();
		portraitSearjar.scrollFactor.set();
		add(portraitSearjar);
		portraitSearjar.visible = false;

		portraitBfA = new FlxSprite(760, 60);
		portraitBfA.frames = Paths.getSparrowAtlas('Singe/bftalk_assets');
		portraitBfA.animation.addByPrefix('enter', 'BftalkA', 24, false);
		portraitBfA.updateHitbox();
		portraitBfA.scrollFactor.set();
		add(portraitBfA);
		portraitBfA.visible = false;

		portraitBfB = new FlxSprite(760, 60);
		portraitBfB.frames = Paths.getSparrowAtlas('Singe/bftalk_assets');
		portraitBfB.animation.addByPrefix('enter', 'BftalkB', 24, false);
		portraitBfB.updateHitbox();
		portraitBfB.scrollFactor.set();
		add(portraitBfB);
		portraitBfB.visible = false;

		portraitBfC = new FlxSprite(760, 60);
		portraitBfC.frames = Paths.getSparrowAtlas('Singe/bftalk_assets');
		portraitBfC.animation.addByPrefix('enter', 'BftalkC', 24, false);
		portraitBfC.updateHitbox();
		portraitBfC.scrollFactor.set();
		add(portraitBfC);
		portraitBfC.visible = false;
	}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFF722228;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFFff4f5a;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						sound.fadeOut(2.2, 0);
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
		case 'dad':
				portraitRight.visible = false;
				portraitSingeA.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'singeA':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeA.visible)
				{
					portraitSingeA.visible = true;
					portraitSingeA.animation.play('enter');
				}
			case 'singeB':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeB.visible)
				{
					portraitSingeB.visible = true;
					portraitSingeB.animation.play('enter');
				}
			case 'singeC':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeC.visible)
				{
					portraitSingeC.visible = true;
					portraitSingeC.animation.play('enter');
				}
			case 'singeD':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeD.visible)
				{
					portraitSingeD.visible = true;
					portraitSingeD.animation.play('enter');
				}
			case 'singeE':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeE.visible)
				{
					portraitSingeE.visible = true;
					portraitSingeE.animation.play('enter');
				}
			case 'singeF':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeF.visible)
				{
					portraitSingeF.visible = true;
					portraitSingeF.animation.play('enter');
				}
			case 'singeG':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeG.visible)
				{
					portraitSingeG.visible = true;
					portraitSingeG.animation.play('enter');
				}
			case 'singeH':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeH.visible)
				{
					portraitSingeH.visible = true;
					portraitSingeH.animation.play('enter');
				}
			case 'singeI':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeI.visible)
				{
					portraitSingeI.visible = true;
					portraitSingeI.animation.play('enter');
				}
			case 'singeJ':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeJ.visible)
				{
					portraitSingeJ.visible = true;
					portraitSingeJ.animation.play('enter');
				}
			case 'singeK':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeK.visible)
				{
					portraitSingeK.visible = true;
					portraitSingeK.animation.play('enter');
				}
			case 'singeL':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeL.visible)
				{
					portraitSingeL.visible = true;
					portraitSingeL.animation.play('enter');
				}
			case 'singeM':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSingeM.visible)
				{
					portraitSingeM.visible = true;
					portraitSingeM.animation.play('enter');
				}
			case 'bfA':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitBfA.visible)
				{
					portraitBfA.visible = true;
					portraitBfA.animation.play('enter');
				}
			case 'bfB':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitBfB.visible)
				{
					portraitBfB.visible = true;
					portraitBfB.animation.play('enter');
				}
			case 'bfC':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitBfC.visible)
				{
					portraitBfC.visible = true;
					portraitBfC.animation.play('enter');
				}
			case 'searjar':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSearjar.visible)
				{
					portraitSearjar.visible = true;
					portraitSearjar.animation.play('enter');
				}
			case 'searA':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearB.visible = false;
				portraitSearC.visible = false;
				if (!portraitSearA.visible)
				{
					portraitSearA.visible = true;
					portraitSearA.animation.play('enter');
				}
			case 'searB':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearC.visible = false;
				if (!portraitSearB.visible)
				{
					portraitSearB.visible = true;
					portraitSearB.animation.play('enter');
				}
			case 'searC':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				portraitSingeB.visible = false;
				portraitSingeC.visible = false;
				portraitSingeD.visible = false;
				portraitSingeE.visible = false;
				portraitSingeF.visible = false;
				portraitSingeG.visible = false;
				portraitSingeH.visible = false;
				portraitSingeI.visible = false;
				portraitSingeJ.visible = false;
				portraitSingeK.visible = false;
				portraitSingeL.visible = false;
				portraitSingeM.visible = false;
				portraitSearjar.visible = false;
				portraitBfA.visible = false;
				portraitBfB.visible = false;
				portraitBfC.visible = false;
				portraitSearA.visible = false;
				portraitSearB.visible = false;
				if (!portraitSearC.visible)
				{
					portraitSearC.visible = true;
					portraitSearC.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitSingeA.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
