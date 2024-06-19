<script>
    import ByteInput from "$lib/ByteInput.svelte";
    import ByteDisplay from "$lib/ByteDisplay.svelte";

    let bytes = [192, 168, 178, 1];

    // Subnet Slider Value
    let sliderValue = (32/4)*3;

    // Calculated bytes
    let subnetBytes = [];
    let deviceBytes = [];
    let networkBytes = [];

    // Bitmaps that represent if a given bit in a byte is in the colored range
    let deviceMaps = [];
    let networkMaps = [];

    $: calculateSubnetBytes(sliderValue);
    $: calculateBytesAndMaps(subnetBytes, bytes)

    function calculateSubnetBytes(sliderValue) {
        let ones = sliderValue;
        let zeros = 32 - sliderValue;
        let s = "";
        for (let i = 0; i < ones; i++) {
            s += "1";
        }
        for (let i = 0; i < zeros; i++) {
            s += "0";
        }
        subnetBytes = s.match(/.{1,8}/g)
            .map(s => parseInt(s, 2));
    }

    function calculateBytesAndMaps(subnet, bytes) {
        subnet.forEach((v, i) => {
            deviceBytes[i] = (255-v) & bytes[i];
            deviceMaps[i] = (255-v);
            networkBytes[i] = v & bytes[i];
            networkMaps[i] = v;
        });
    }
</script>

<main>
    <div class="block">
        <div class="grid">
            <h3>IP</h3>
            <div class="bytes">
                <ByteInput bind:output={bytes[0]}/>
                <ByteInput bind:output={bytes[1]}/>
                <ByteInput bind:output={bytes[2]}/>
                <ByteInput bind:output={bytes[3]} last={true}/>
            </div>
            <div class="bytes">
                {#each bytes as byte, i}
                    <ByteDisplay bind:byte={byte}/>
                    {#if (i+1 !== bytes.length)}
                        <span>.</span>
                    {/if}
                {/each}
            </div>

            <h3 style="grid-column: 1 / 3">Subnetz Maske</h3>
            <div class="bytes">
                <span>{subnetBytes[0]}</span>.
                <span>{subnetBytes[1]}</span>.
                <span>{subnetBytes[2]}</span>.
                <span>{subnetBytes[3]}</span>
            </div>
            <div>
                <input type="range" class="slider" bind:value={sliderValue} min="0" max="32" step="1">
                <div class="bytes">
                    {#each subnetBytes as byte, i}
                        <ByteDisplay colored={true} bind:byte={byte}/>
                        {#if (i+1 !== subnetBytes.length)}
                            <span>.</span>
                        {/if}
                    {/each}
                </div>
            </div>
            <h3>Netz Teil</h3>
            <div class="bytes">
                <span>{networkBytes[0]}</span>.
                <span>{networkBytes[1]}</span>.
                <span>{networkBytes[2]}</span>.
                <span>{networkBytes[3]}</span>
            </div>
            <div class="bytes">
                {#each networkBytes as byte, i}
                    <ByteDisplay colored bind:map={networkMaps[i]} bind:byte={byte}/>
                    {#if (i+1 !== networkMaps.length)}
                        <span>.</span>
                    {/if}
                {/each}
            </div>
            <h3>Geräte Teil</h3>
            <div class="bytes">
                <span>{deviceBytes[0]}</span>.
                <span>{deviceBytes[1]}</span>.
                <span>{deviceBytes[2]}</span>.
                <span>{deviceBytes[3]}</span>
            </div>
            <div class="bytes">
                {#each deviceBytes as byte, i}
                    <ByteDisplay colored bind:map={deviceMaps[i]} bind:byte={byte}/>
                    {#if (i+1 !== networkMaps.length)}
                        <span>.</span>
                    {/if}
                {/each}
            </div>
        </div>

    </div>
</main>

<style>
    :global(body) {
        margin: 0;
        padding: 0;
    }

    :root {
        font-size: 2vw;
    }
    :global(input) {
        font-size: 1rem;
        text-align: center;
        color: orange;
    }
    * {
        margin: 0;
    }
    .block {
        max-width: 150ch;
        display: grid;
        gap: .5rem;
        font-family: monospace;
    }

    .bytes {
        margin-top: auto;
        display: grid;
        grid-template-columns: repeat(4, 1fr auto);
    }
    .bytes > span {
        margin: auto;
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

    .grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: .5rem 1rem;
    }

    .grid h3 {
        grid-column: 1 / 3;
    }

    main {
        box-sizing: border-box;
        display: grid;
        height: 100dvh;
        width: 100vw;
        align-items: center;
        padding: 1rem;
    }
</style>