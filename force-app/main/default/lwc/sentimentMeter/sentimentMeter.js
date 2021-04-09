import { LightningElement, api } from 'lwc';

export default class SentimentMeter extends LightningElement {
    score = '';
    variant = '';
    title = '';
    @api
    type = 'Video';

    constructor() {
        super();
        this.score = Math.random().toFixed(2) * 100;
        if (this.score > 70) {
            this.variant = 'base';
        } else if (this.score > 50 && this.score < 70) {
            this.variant = 'active-step';
        } else if (this.score > 20 && this.score < 50) {
            this.variant = 'warning';
        } else if (this.score < 20) {
            this.variant = 'expired';
        }
        this.title = this.type? this.type : 'Video' +' Sentiment Score: ' + this.score + '%';
    }
}