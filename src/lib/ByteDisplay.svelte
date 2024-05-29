<script>
    export let byte;
    export let colored = false;
    export let map = 0;

    let display = [];
    $: {
        for (let i = 0; i < 8; i++) {
            let number = Math.pow(2, i);
            display[i] = (number & byte) === number ? "1" : "0";
        }
    }
</script>

<div>
    {#each display as _, i}
        {@const value = display[7-i] }
        {@const mapped = (map & (Math.pow(2, 7 - i))) !== Math.pow(2, 7 - i)}
        {@const color = colored ? value === "1" ? "green" : "red" : ""}
        {@const styleClasses = mapped ? color : "blue"}
        <span class={styleClasses}>{value}</span>
    {/each}
</div>

<style>
    span {
        font-family: monospace;
    }
    div {
        display: flex;
        justify-content: space-between;
    }

    .red {
        color: red;
    }
    .green {
        color: #04AA6D;
    }
    .blue {
        color: blue;
    }
</style>
