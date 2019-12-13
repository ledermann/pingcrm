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
      group="default"
      position="top center"
      width="50%"
      classes="my-notification-style"
    />

    <slot />
  </div>
</template>

<script>
export default {}
</script>
