/**
 * Util.js
 */
import { mainWord } from './stores.js'

export const Util = {
    ArrayUtil: {
        shuffle: (arr) => {
            var currentIndex = arr.length,  randomIndex;

            while (currentIndex != 0) {
                // Pick a remaining element...
                randomIndex = Math.floor(Math.random() * currentIndex);
                currentIndex--;

                // And swap it with the current element.
                [arr[currentIndex], arr[randomIndex]] = [
                arr[randomIndex], arr[currentIndex]];
            }

            return arr;
        }
    },

    ServiceUtil: {
        loadData: async () => {
            try {
                let response = await fetch(MHX.dataUrl)

                if(response.status == 200) {
                    let json = await response.json()
                    return json
                }

                throw new Error("meh, something went wrong", response.status)
            } catch(err) {
                console.error(err) // TypeError: failed to fetch
            }
        }
    },

    StoreUtil: {
        setMainWord: word => $mainWord = word
    }
}