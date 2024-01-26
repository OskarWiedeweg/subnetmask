<script>
    export let output;
    export let last = false;
</script>

<input type="number" bind:value={output} min="0" max="255" step="1"/>
{#if (!last)}.{/if}