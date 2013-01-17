class AwesomeEnemySpawner extends AwesomeActor
    placeable;
var MinionBot MySpawnedMinion;
var HeavyBot MySpawnedHeavy;
var BomberBot MySpawnedBomber;
    
function MakeEnemyRunAway()
{
    //if(MySpawnedEnemy != none) MySpawnedEnemy.RunAway();
}
    
function SpawnMinion()
{
    if(MySpawnedMinion == none) MySpawnedMinion = spawn(class'MinionBot', self,, Location);
}

function SpawnHeavy()
{
    if(MySpawnedHeavy == none) MySpawnedHeavy = spawn(class'HeavyBot', self,, Location);
}

function SpawnBomber()
{
    if(MySpawnedBomber == none) MySpawnedBomber = spawn(class'BomberBot', self,, Location);
}

function SpawnBoss()
{
    spawn(class'AwesomeBoss', self,, Location);
}

function bool CanSpawnEnemy()
{
    return true; //MySpawnedEnemy == none;
}

defaultproperties
{
    Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_NavP'
        HiddenGame=true
    End Object
    Components.Add(Sprite)
}