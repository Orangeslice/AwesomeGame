class AwesomeWeaponUpgrade extends AwesomeActor
hidecategories(Attachment,Physics,Debug,Object)
    placeable;
    
    var float velRotation;
    
    event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
    {
        if(Pawn(Other) != none && AwesomeWeapon(Pawn(Other).Weapon) !=none)
        {
            AwesomeWeapon(Pawn(Other).Weapon).UpgradeWeapon();
            Destroy();
        }
    }
    
    function Tick(float DeltaTime)
    {
        local float deltaRotation;
        local Rotator newrotation;
        
        deltaRotation = velRotation * DeltaTime;
        
        newRotation = Rotation;
        
        //newRotation.Pitch += deltaRotation;
        newRotation.Yaw += deltaRotation;
        //newRotation.Roll += deltaRotation;
        
        SetRotation( newRotation );
    }

defaultproperties
{
    bCollideActors=true
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=true
    End Object
    Components.Add(MyLightEnvironment)
    Begin Object Class=StaticMeshComponent Name=PickupMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
        LightEnvironment=MyLightEnvironment
        Scale3D=(X=0.125,Y=0.125,Z=0.125)
    End Object
    Components.Add(PickupMesh)
    Begin Object Class=CylinderComponent Name=CollisionCylinder
        CollisionRadius=16.0
        CollisionHeight=16.0
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        BlockActors=true
        CollideActors=true
    End Object
    CollisionComponent=CollisionCylinder
    Components.Add(CollisionCylinder)
    
    velRotation = 5000
}