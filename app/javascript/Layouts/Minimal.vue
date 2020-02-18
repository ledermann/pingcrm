<template>
  <div>
    <portal-target
      name="modal"
      slim
    />

    <portal-target
      name="dropdown"
      slim
    />

    <notifications
      position="top center"
      classes="flash"
    />

    <slot />
  </div>
</template>

<script>
export default {}
</script>
