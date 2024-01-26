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
    <span class:blue={(map & 128) === 128} class:red={colored && (display[7] === "0")} class:green={colored && display[7] === "1"}>{display[7]}</span>
    <span class:blue={(map & 64) === 64} class:red={colored && display[6] === "0"} class:green={colored && display[6] === "1"}>{display[6]}</span>
    <span class:blue={(map & 32) === 32} class:red={colored && display[5] === "0"} class:green={colored && display[5] === "1"}>{display[5]}</span>
    <span class:blue={(map & 16) === 16} class:red={colored && display[4] === "0"} class:green={colored && display[4] === "1"}>{display[4]}</span>
    <span class:blue={(map & 8) === 8} class:red={colored && display[3] === "0"} class:green={colored && display[3] === "1"}>{display[3]}</span>
    <span class:blue={(map & 4) === 4} class:red={colored && display[2] === "0"} class:green={colored && display[2] === "1"}>{display[2]}</span>
    <span class:blue={(map & 2) === 2} class:red={colored && display[1] === "0"} class:green={colored && display[1] === "1"}>{display[1]}</span>
    <span class:blue={(map & 1) === 1} class:red={colored && display[0] === "0"} class:green={colored && display[0] === "1"}>{display[0]}</span>
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
