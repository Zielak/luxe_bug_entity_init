
import luxe.Color;
import luxe.Component;
import luxe.Entity;
import luxe.Input;
import luxe.options.EntityOptions;
import luxe.Scene;
import luxe.Visual;

class Main extends luxe.Game {

    var myscene:Scene;

    var hud:Hud;
    var vis1:Visual;
    var things_in_vis1:Array<Visual>;

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

        myscene = new Scene('myscene');

        hud = new Hud({
            name: 'hud',
        });

        vis1 = new Visual({
            name: 'vis1',
            pos: new luxe.Vector(100, 100),
            geometry: Luxe.draw.box({
                x: 0, y: 0,
                w: 100,
                h: 50,
            }),
            color: new Color(0.1, 0.2, 0.1, 1),
            scene: Hud.hud_scene,
        });
        things_in_vis1 = new Array<Visual>();

        // Test init when adding entities right away!
        // test1();
        // test2();
        // test3();
        // test4parent();
        // test5_hudscene();
        // test6_hudscene_component();
        // test7_hudscene_parent_component();

        add_to_vis1();

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

        // if(e.keycode == Key.key_1) {
        //     test1();
        // }
        // if(e.keycode == Key.key_2) {
        //     test2();
        // }
        // if(e.keycode == Key.key_3) {
        //     test3();
        // }
        // if(e.keycode == Key.key_4) {
        //     test4parent();
        // }
        // if(e.keycode == Key.key_5) {
        //     test5_hudscene();
        // }
        // if(e.keycode == Key.key_6) {
        //     test6_hudscene_component();
        // }
        // if(e.keycode == Key.key_7) {
        //     test7_hudscene_parent_component();
        // }


        if(e.keycode == Key.key_a) {
            add_to_vis1();
        }
        if(e.keycode == Key.key_d) {
            remove_from_vis1();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


/*
    function test1() {

        trace('=== #TEST1# adding just new TestEntity ===');
        var newEntity = new TestEntity({
            name:'test_1',
            name_unique: true,
            scene: myscene,
        });

        trace('   entity.name: ${newEntity.name}');
    }

    function test2() {
        
        trace('=== #TEST2#  adding new Entity with TestComponent ===');
        var newEntity = new Entity({
            name:'test_2',
            name_unique: true,
            scene: myscene,
        });
        newEntity.add( new Main.TestComponent({name:'testComponent'}) );

        trace('   entity.name: ${newEntity.name}');
    }

    function test3() {
        
        trace('=== #TEST3#  adding new TestEntity with TestComponent ===');
        var newEntity = new TestEntity({
            name:'test_3',
            name_unique: true,
            scene: myscene,
        });
        newEntity.add( new Main.TestComponent({name:'testComponent'}) );

        trace('   entity.name: ${newEntity.name}');
    }

    function test4parent() {
        
        trace('=== #TEST4#  adding new TestEntity with TestComponent ===');
        var newEntity = new TestEntity({
            name:'test_4',
            name_unique: true,
            scene: myscene,
        });
        newEntity.add( new Main.TestComponent({name:'component'}) );

        var childEntity = new TestEntity({
            name:'child',
            name_unique: true,
            parent: newEntity,
        });
        childEntity.add( new Main.TestComponent({name:'component'}) );

        trace('   entity.name: ${newEntity.name}');
    }

    function test5_hudscene() {

        trace('=== #TEST5# adding just new TestEntity to hud_scene ===');
        var newEntity = new TestEntity({
            name:'test_5',
            name_unique: true,
            scene: Hud.hud_scene,
        });

        trace('   entity.name: ${newEntity.name}');

    }

    function test6_hudscene_component() {

        trace('=== #TEST6# adding just new TestEntity with Component to hud_scene ===');
        var newEntity = new TestEntity({
            name:'test_6',
            name_unique: true,
            scene: Hud.hud_scene,
        });
        newEntity.add( new Main.TestComponent({name:'component'}) );

        trace('   entity.name: ${newEntity.name}');

    }

    function test7_hudscene_parent_component() {

        trace('=== #TEST7# new TestEntity with child and Component to hud_scene ===');
        var newEntity = new TestEntity({
            name:'test_7',
            name_unique: true,
            scene: Hud.hud_scene,
        });
        newEntity.add( new Main.TestComponent({name:'component'}) );

        var childEntity = new TestEntity({
            name:'child',
            name_unique: true,
            parent: newEntity,
        });
        childEntity.add( new Main.TestComponent({name:'component'}) );

        trace('   entity.name: ${newEntity.name}');

    }
*/


    function add_to_vis1() {

        trace('add_to_vis1()');
        for(i in 0...3){
            var vis = new TestVisual({
                name: 'child${i}',
                name_unique: true,
                geometry: Luxe.draw.ngon({
                    x: 0, y: 0,
                    r: Math.random()*40+10,
                    sides: Math.ceil( Math.random()*5)+2,
                }),
                scene: Hud.hud_scene,
                depth: 2,
                parent: vis1,
            });

            vis.add( new Main.TestComponent({name: 'compo'}));

            things_in_vis1.push( vis );
        }

    }

    function remove_from_vis1() {

        trace('remove_from_vis1()');
        for(i in things_in_vis1){
            i.destroy();
        }

    }

} //Main


class Hud extends Entity {

    public static var hud_scene:Scene;


    override public function new( options:EntityOptions )
    {

        super(options);
        hud_scene = new Scene('hud_scene');

    }

}


// class TestEntity extends Entity {

//     override function init() {
//         trace('   [${this.name}] TestEntity.init();');
//     }

// }

class TestVisual extends Visual {

    override function init() {
        trace('   [${this.name}] Visual.init();');
    }

}

class TestComponent extends Component {

    override function init() {
        trace('   [${entity.name}]/[${this.name}] TestComponent.init();');
    }

    override function onadded() {
        trace('   [${entity.name}]/[${this.name}] TestComponent.onadded();');
    }

}
