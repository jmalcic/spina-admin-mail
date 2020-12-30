export class MailTableController extends Stimulus.Controller {
  static get targets() {
    return ['row', 'link', 'editButton', 'hiddenIcon']
  }

  toggleEdit() {
    this.linkTargets.forEach(link => link.classList.toggle('table-link'))
    this.editButtonTarget.classList.toggle('button-success')
    this.hiddenIconTargets.forEach(target => target.toggleAttribute('data-hidden'))
    if (this.data.has('editing')) {
      this.editButtonTarget.querySelector('i').classList.replace('icon-check', 'icon-cog')
      this.data.delete('editing')
    } else {
      this.editButtonTarget.querySelector('i').classList.replace('icon-cog', 'icon-check')
      this.data.set('editing', '')
    }
  }
}
