import alert from './alert.twig';
import data from './alert.yml';

const settings = {
  title: 'Components/Alert',
};

// Default alert story.
export const Alert = {
  render: (args) => alert(args),
  args: { ...data },
};

export const Danger = {
  ...Alert,
  name: 'Danger alert',
  args: {
    ...data,
    modifier: 'alert--danger',
    text: 'A simple danger alert-check it out!',
  },
  
};

export default settings;
