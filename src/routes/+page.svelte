<script>
    import ByteInput from "$lib/ByteInput.svelte";
    import ByteDisplay from "$lib/ByteDisplay.svelte";

    let bytes = [192, 168, 178, 1];

    let sub = (32/4)*3;

    let subnet = [];
    $: {
        let ones = sub;
        let zeros = 32 - sub;
        let s = "";
        for (let i = 0; i < ones; i++) {
            s += "1";
        }
        for (let i = 0; i < zeros; i++) {
            s += "0";
        }
        subnet = s.match(/.{1,8}/g).map(s => parseInt(s, 2));
    }

    let device = [];
    let deviceMaps = [];
    let network = [];
    let networkMaps = [];

    $: {
        subnet.forEach((v, i) => {
            device[i] = (255-v) & bytes[i];
            deviceMaps[i] = (255-v);
            network[i] = v & bytes[i];
            networkMaps[i] = v;
        });
    }
</script>

<div class="block">
    <h3>IP</h3>
    <div class="bytes" style="font-family: monospace">
        <ByteInput bind:output={bytes[0]}/>
        <ByteInput bind:output={bytes[1]}/>
        <ByteInput bind:output={bytes[2]}/>
        <ByteInput bind:output={bytes[3]} last={true}/>

        <ByteDisplay bind:byte={bytes[0]}/>.
        <ByteDisplay bind:byte={bytes[1]}/>.
        <ByteDisplay bind:byte={bytes[2]}/>.
        <ByteDisplay bind:byte={bytes[3]}/>
    </div>
    <h3>Subnetz Maske</h3>
    <input type="range" class="slider" bind:value={sub} min="0" max="32" step="1">
    <div class="bytes">
        <span>{subnet[0]}</span>.
        <span>{subnet[1]}</span>.
        <span>{subnet[2]}</span>.
        <span>{subnet[3]}</span>
        <ByteDisplay colored={true} bind:byte={subnet[0]}/>.
        <ByteDisplay colored="true" bind:byte={subnet[1]}/>.
        <ByteDisplay colored="true" bind:byte={subnet[2]}/>.
        <ByteDisplay colored="true" bind:byte={subnet[3]}/>
    </div>
    <h3>Netz Teil</h3>
    <div class="bytes">
        <span>{network[0]}</span>.
        <span>{network[1]}</span>.
        <span>{network[2]}</span>.
        <span>{network[3]}</span>
        <ByteDisplay colored bind:map={networkMaps[0]} bind:byte={network[0]}/>.
        <ByteDisplay colored bind:map={networkMaps[1]} bind:byte={network[1]}/>.
        <ByteDisplay colored bind:map={networkMaps[2]} bind:byte={network[2]}/>.
        <ByteDisplay colored bind:map={networkMaps[3]} bind:byte={network[3]}/>
    </div>
    <h3>Geräte Teil</h3>
    <div class="bytes">
        <span>{device[0]}</span>.
        <span>{device[1]}</span>.
        <span>{device[2]}</span>.
        <span>{device[3]}</span>
        <ByteDisplay colored bind:map={deviceMaps[0]} bind:byte={device[0]}/>.
        <ByteDisplay colored bind:map={deviceMaps[1]} bind:byte={device[1]}/>.
        <ByteDisplay colored bind:map={deviceMaps[2]} bind:byte={device[2]}/>.
        <ByteDisplay colored bind:map={deviceMaps[3]} bind:byte={device[3]}/>
    </div>
</div>

<style>
    * {
        margin: 0;
    }
    .block {
        max-width: 80ch;
        margin: auto;
        display: grid;
        gap: .5rem;
        font-family: monospace;
    }

    .bytes {
        display: grid;
        gap: .5rem;
        grid-template-columns: auto 1ch auto 1ch auto 1ch auto;
    }

    .slider {
        -webkit-appearance: none;
        width: 100%;
        height: 25px;
        background: #d3d3d3;
        outline: none;
        opacity: 0.7;
        -webkit-transition: .2s;
        transition: opacity .2s;
    }

    .slider:hover {
        opacity: 1;
    }

    .slider::-webkit-slider-thumb {
        -webkit-appearance: none;
        appearance: none;
        width: calc(100%/35);
        height: 25px;
        background: #04AA6D;
        cursor: pointer;
    }

    .slider::-moz-range-thumb {
        width: 25px;
        height: 25px;
        background: #04AA6D;
        cursor: pointer;
    }

    h3:not(:first-child) {
        margin-top: 2rem;
    }
    h3 {
        border-bottom: 1px solid #d3d3d3;
    }
</style>