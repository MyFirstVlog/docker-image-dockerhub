const { syncDB } = require("../../tasks/sync-db");



describe('Pruebas en sync-db', () => {
    
    test('debe de ejecutar el proceso dos veces', () => {
        syncDB()
        const times = syncDB();

        expect(times).toBe(2);
        
    });

});